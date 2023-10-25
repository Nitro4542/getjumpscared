# getjumpscared

A single Powershell script which will trigger a jumpscare from Five Nights at Freddy's which was written in Python    

I'm not sure if this works on Linux or Mac, because I obviously designed it for Windows.  

## Dependencies

- Python  

- The following libraries, which will be automatically installed:  

```bat
pip install opencv-python
pip install pygame
pip install pycaw
pip install comtypes
```

## How to use it

Just run the Powershell script.  

Please note that you'll need non-restricted internet access for it to work.  

You can also change the jumpscare video and audio links if you like.

## How does it work?

Here is everything the script does:  

- Check if Python is installed  
- If Python is installed, install opencv-python, pygame, pycaw and comtypes using pip  
- Create a folder called "jumpscare" inside %temp% if it doesn't exist  
- Copy the python script to jumpscare.py inside %temp%\jumpscare  
- Download an MP4 file for the jumpscare from this repository (if it doesn't exist in the temp folder)  
- Download an MP3 file for the jumpscare from this repository (if it doesn't exist in the temp folder)  
- Run the jumpscare.py script  

## How to make it seem more legit

Feel free to change the folder where it will be installed to something else.  

## How to Contribute

You can help by fixing some bugs, create issues or create pull requests.  

All though this is a project I made in 2 hours, help is highly appreciated!

## Disclaimer

I am not responsible for any damage you do with this script.