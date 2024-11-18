# Demo Duplicator

A script to help you Fool the TA when He/She is becoming annoying and telling you to download you assignment from GCR.

## Instructions

0. Clone this repository.To run this script, open powershell and run

```
 ./demo-duplicator.ps1
```

1. Change the download destination folder of your browser.For chrome you can do it here: `chrome://settings/downloads`
2. Place your changed assignment in a folder other than the Downloads folder and also in the Downloads folder.
3. The Downloads folder is the destination folder and the other folder is your source folder.
4. Run the script and add your destination and source folder including the file name. You can copy the path using `Ctrl+Shift+C`.
5. Remember to remove quotation marks before pressing enter.
6. Done! Now if the Downloads folder is cleaned and you have to download the Assignment from GCR, the file will be downloaded in another folder. Meanwhile, the script will copy the changed file from the source to the destination, making it seem like you downloaded it from GCR.
7. Remember... Open powershell to run this script not command prompt

Enjoy!

## Example

```powershell
.\DemoDuplicator.ps1 -Destination "C:\Users\muham\Downloads\assignment.docx" -Source "C:\Users\muham\Documents\assignment.docx"
```

## Disclaimer

You are on your own if you get caught!. However if you get caught even after this much effort, maybe you are the problem.
