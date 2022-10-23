# BgInfo Custom Network Info

For network related fields, [Sysinternals BgInfo](https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo) prints information for all network interfaces to the desktop.  This printout can be overwhelming, and even limit or prevent desktop space for other fields.  Therefore, if you need to display network interface(s), you may need to create a custom field.

Here, I use a powershell script to write active interface info to a file at boot up.  Then, BgInfo uses the file content as a custom field.

## Configure BgIno
1. Download and extract *BGInfo.zip*
2. Open another Windows Explorer
3. Click in the location bar and type: `shell:startup` (user) or `shell:common startup`  (system)
4. Place *Bginfo64.exe* in this folder -- BgInfo will run at boot up
5. Change name to: *2_Bginfo64.exe*
5. Open *2_Bginfo64.exe*
6. Click the ***Time remaining*** box to prevent the app from closing
7. Format the layout within the editor

![bginfo app](https://github.com/briantgil/bginfo-custom-network-info/blob/main/bginfo.png)

## Configure custom field
1. Download *bginfo_custominfo.ps1* and place into *c:\users\\\<username>*, or a preferred directory
2. Download *1_bginfo_custominfo.bat* and place into the startup folder from #3 above
3. Open *bginfo_custominfo.ps1* and enter MAC addresses into `$nic_macs` array to allow printing (interface must be up)
4. Open *1_bginfo_custominfo.bat* and enter the correct script path from #1
5. Run *1_bginfo_custominfo.bat*
5. Open *2_Bginfo64.exe*
6. Click the ***Time remaining*** box to prevent the app from closing
7. Click **Custom**
8. Click **New**
9. Enter **Identifier**
10. Select **Contents of a file**
11. Click **Browse**
12. Browse to: *c:\users\\\<username>\bginfo_custom_info.txt*
13. Click **OK**
14. Click **Apply**
15. Click **OK**
16. Verify BgInfo displays the information properly
17. Network info will overwrite on reboots

\*used this file location to bypass permission issues
