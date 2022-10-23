# BgInfo Custom Network Info

For network related fields, [Sysinternals BgInfo](https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo) prints information for all network interfaces to the desktop.  This printout can be overwhelming, and even limit or prevent desktop space for other fields.  Therefore, if you need to display network interface(s), you may need to create a custom field.

Here, I use a powershell script to write active interface info to a file at boot up.  Then, BgInfo uses the file content as a custom field.

## Configure BgIno
1. Download and extract *BGInfo.zip*
2. Place *Bginfo64.exe* into *c:\users\\\<username>*, or a preferred directory*
5. Open *Bginfo64.exe*
6. Click the ***Time remaining*** box to prevent the app from closing
7. Format the layout within the editor

## Configure custom fields
1. Download *bginfo_custominfo.ps1* and place into *c:\users\\\<username>*, or a preferred directory**
4. Open Windows Explorer and type into the location bar: `shell:startup` (user) or `shell:common startup`  (system)
2. Download *bginfo_custominfo.bat* and place into the startup folder from above
3. Edit *bginfo_custominfo.ps1* and enter MAC address strings into `$nic_macs` array to allow printing (interfaces must be up)
4. Edit *bginfo_custominfo.bat* and enter correct paths
5. Run *bginfo_custominfo.bat* by double clicking it
5. Open *Bginfo64.exe*
6. Click the ***Time remaining*** box to prevent the app from closing
7. Click **Custom** > Click **New** > Enter **Identifier** > Select **Contents of a file** > Click **Browse**
12. Browse to: *c:\users\\\<username>\bginfo_custom_info.txt*
13. Click **OK**
14. Select **Identifier** from within Fields pane
15. Click **Apply** > Click **OK**
16. Verify BgInfo displays the information properly
17. Network info will overwrite on reboots

![bginfo app](https://github.com/briantgil/bginfo-custom-network-info/blob/main/bginfo.png)

*used this file location to bypass permission issues

**ensure Powersehell Execution Policy is set to allow running scripts

