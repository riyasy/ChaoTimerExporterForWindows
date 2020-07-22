# ChaoTimerCSVExport

Chao Timer (https://apps.apple.com/us/app/chaotimer-professional-cube-timer/id537516001) is a popular iPhone app for measuring Rubik's Cube solve timings. One limitation of this app is we cannot export the data from the app to a usable form like a csv or text.

The following workflow was followed to get the data out of the Chao Timer.

1. Using iTunes, take an unencrypted back of your iPhone to your windows PC.
2. Install free version of iBackup viewer https://www.imactools.com/iphonebackupviewer/
3. Use iBackup viewer to open the back up file of your iPhone
4. Click the "Raw Files" option. Navigate to AppDomain>Jicho.ChaoTimer.
5. You can see files corresponding to the sessions created on Chao Timer on right.
6. Export all the session files to a folder in your PC
7. These are binary PList files and cannot be opened in your PC
6. Install Notepad++ 
7. Using plugins admin, search and install "Notepad++ bplist plugin"
8. Open each plist file created in step 7. You will be able to see the proper xml format of the session data with all the solves.
9. Copy the text from notepad++ to a new text file and save it in another folder.(Don't use save as. Copy from the plist and paste in another new text)
10. Repeat step 9 for all the plist files created in Step 6.
11. Now you will have a new folder with the xml plists for each session.
12. Run the ChaoTimerCSVExporter.exe. Give the folder in Step 11 as input.
13. The result CSV will be generated in the same folder.
