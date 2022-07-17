# Raspberry-Pi
All Raspberry Pi Backups, Commands, Instructions for domian.network Servers

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

#### All CMD Commands:
```bash
cd 
sudo apt install cifs-utils
sudo mkdir /mnt/WindowsSharedFolder
mount.cifs //192.168.1.1/c$/inetpub/wwwroot/SharedFolderNameOnWindows /mnt/WindowsSharedFolder -o user=<admin user>
```
