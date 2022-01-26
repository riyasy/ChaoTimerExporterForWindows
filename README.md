# ChaoTimer CSV Export

Chao Timer (https://apps.apple.com/us/app/chaotimer-professional-cube-timer/id537516001) is a popular iPhone app for measuring Rubik's Cube solve timings. One limitation of this app is we cannot export the data from the app to a usable form like a csv or text.

The following workflow was followed to get the data out of the Chao Timer.

1. Using iTunes, take an unencrypted back of your iPhone to your windows PC.
2. Install free version of iBackup viewer https://www.imactools.com/iphonebackupviewer/
3. Use iBackup viewer to open the back up file of your iPhone
4. Click the "Raw Files" option. Navigate to AppDomain>Jicho.ChaoTimer.
5. You can see files corresponding to the sessions created on Chao Timer on right.
6. Export all the session files to a folder in your PC (Make sure only plist files corresponding to session are copied)
7. Copy these plist files to your MAC 
8. Set the input directory properly in main.m
9. Execute the program
10. CSC content is generated as a file in Documents folder.


Uses the data classes from the original ChaoTimer App Source Code
https://github.com/nijixuchao/ChaoTimer

