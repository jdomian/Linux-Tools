# Raspberry-Pi --- Custom Tools I use (With a Cyberpunk flavor)
All Raspberry Pi Backups, Commands, Instructions for baasic installation of tools I use.

## To Install tools:
1. SSH into your Linux operating system with Terminal application on Windows, MacOS or Linux. (Replace the <ip address> with the IP Address the device/computer/machine is addigned to on your local network) 
```bash
ssh <user>@<ip address>
```
Example if your device had an IP address of 192.168.1.100 and the user name was "root".:
```bash
ssh root@192.168.1.100
```
2. Copy and paste the following into terminal to run and install my custom menu. (Cyberpunk themed whiptail menu... FTW...)
```bash
curl https://raw.githubusercontent.com/jdomian/Raspberry-Pi/main/_install.sh --output _install.sh
chmod +x _install.sh
sudo ./_install.sh

```

# Access Windows Shared drive on Linux (smb:// drive)
### Reference: 
https://www.maketecheasier.com/mount-windows-share-folder-linux/
### Use Case:
To access root directory from a Windows shared folder via Linux to edit code through code-server installed on RPi4 and hosted at code-server.domian.network.

#### Steps & Commands:
1. Create a Windows shared folder on a Windows machine. Give Full control access to all users. We will reference this folder as "SharedFolderNameOnWindows" in the next steps.
2. On Linux, install CIFS-utils. Run:
```bash
cd 
sudo apt install cifs-utils
```
3. Make a directory on Linux where you will mount the shared drive. Name this directory whatever you want. Example, run:
```bash
sudo mkdir /mnt/WindowsSharedFolder
```
4. Once directory is created, run the following with the network address of the Windows machine and the file path for the Windows machine's shared folder. Change ```<admin user>``` to the admin user on the Windows machine.
```bash
mount.cifs //192.168.1.1/c$/inetpub/wwwroot/SharedFolderNameOnWindows /mnt/WindowsSharedFolder -o user=<admin user>
```
This should prompt you for a "ghosted" password. Enter the password for the ```user=<admin username>``` used in the above command.

5. Windows drive should now be accessible on Linux at ```/mnt/WindowsSharedFolder```.

#### All bash commands for file share:
```bash
cd 
sudo apt install cifs-utils
sudo mkdir /mnt/WindowsSharedFolder
mount.cifs //192.168.1.1/c$/inetpub/wwwroot/SharedFolderNameOnWindows /mnt/WindowsSharedFolder -o user=<admin user>
```

# Bluetooth connect Keyboard and Mouse to Raspberry Pi via CLI
### Reference: https://www.cnet.com/tech/computing/how-to-setup-bluetooth-on-a-raspberry-pi-3/
### Should work for factory Raspian OS installed. Others are untested.

#### Steps & Commands:
1. In terminal, change directory into "home" folder for user.
```bash
cd
```
2. Run the following to start bluetooth services.
```bash
sudo bluetoothctl
```
3. Turn on the bluetooth agent for detection.
```bash
agent on
```
4. Turn scanning on...
```bash
scan on
```
5. Look through list for MAC address and/or names of bluetooth devices you want to connect. Take note of MAC address, and "pair" by typing in "pair" followed by the devices MAC address.
```bash
pair XX:XX:XX:XX:XX:XX
```
6. If you're pairing a keyboard, you will need to enter a six-digit string of numbers. You will see that the device has been paired, but it may not have connected. To connect the device, type connect XX:XX:XX:XX:XX:XX.
```bash
connect XX:XX:XX:XX:XX:XX
```

#### All bash commands for bluetooth -- Personal MAC addresses for Keychron K4 (Bluetooth Input 3) and MX Master 3 (Bluetooth Input 3) below:
```bash
cd
echo This is for Keychron K4 and MX Master 3 using bluetooth input "3" on both devices.
sudo bluetoothctl
agent on
scan on
echo Pairing Keychron K4 (Bluetooth Input 3)
pair dc:2c:26:d4:f8:2b
echo Pairing MX Master 3 (Bluetooth Input 3)
pair c1:6c:7e:13:63:d5
```
## Waveshare WM8960 on RPi0 2w
Run the following
1. Install Legacy 64-Bit Lite OS on SD Card
2. Insert SD Card and wait for boot
3. Update, Upgrade and install Git
```bash
sudo apt-get upgrade && sudo apt-get update -y && sudo apt-get install git -y
```   
4. Install Waveshare drivers. Can use (this)[https://www.waveshare.com/wiki/WM8960_Audio_HAT#202302_System.2C_Driver_Loading] as a reference 
```bash
git clone https://github.com/Sybility/WM8960-Audio-HAT.git
cd WM8960-Audio-HAT
sudo ./install.sh
```
5. Reboot after Waveshare drivers are installed
6. Enter raspi-config and do the following... System options ; Audio ; and then choose the wm8960soundcard. Then exit.
7. Run the following command
```bash
sudo alsactl --file=/etc/wm8960-soundcard/wm8960_asound.state  store
```
8. Install an mp3 player to test
```bash
sudo apt-get install mpg123
```
9. Download and test and MP3 file
```bash
wget https://file-examples.com/storage/fe9f6f893066954d9aac3a2/2017/11/file_example_MP3_700KB.mp3
```
10. Test the MP3 file
```bash
sudo mpg123 file_example_MP3_700KB.mp3
```
