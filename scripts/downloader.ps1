# This will jumpscare you. I am not responsible if you get a heart attack.
# Detect if Python is installed
$pythonPath = Get-Command python -ErrorAction SilentlyContinue

# jumpscare.py
$jumpscareScript = @"
# Attention: If you run this program, you will get jumpscared.
# If you die from a heart attack I am not responsible.

# Set volume to maximum
import cv2
import pygame
import ctypes
import os
from ctypes import cast, POINTER
from comtypes import CLSCTX_ALL
from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume

devices = AudioUtilities.GetSpeakers()
interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
volume = cast(interface, POINTER(IAudioEndpointVolume))

volume.SetMasterVolumeLevel(0.0, None)

# Play video
# Path to the video & audio
video_path = os.getenv("TEMP") + "\jumpscare\js_video.mp4"
audio_path = os.getenv("TEMP") + "\jumpscare\js_audio.mp3"
# Create a VideoCapture object
cap = cv2.VideoCapture(video_path)

# Check if the video opened successfully
if not cap.isOpened():
    print("Error opening the video.")
    exit()

# Create a video window and open it in fullscreen mode
cv2.namedWindow("Video", cv2.WND_PROP_FULLSCREEN)
cv2.setWindowProperty("Video", cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)

# Init pygame & play audio
pygame.init()
pygame.mixer.init()
pygame.mixer.music.load(audio_path)
pygame.mixer.music.play()
pygame.event.wait()

# Display video frames & hide cursor
while True:
    ctypes.windll.user32.ShowCursor(False)
    ret, frame = cap.read()
    if not ret:
        break

    cv2.imshow("Video", frame)

    # Play the video and wait for a key to close the window
    if cv2.waitKey(30) & 0xFF == ord('q'):
        break

# Release the VideoCapture object and close the window & restore cursor
ctypes.windll.user32.ShowCursor(True)
cap.release()
cv2.destroyAllWindows()
"@

# Install needed packages if python is installed (silent)
if ($pythonPath) {
    Write-Host "Installing... Do NOT close this window."
    cmd /c "echo "yes" | pip install opencv-python -q -q -q --exists-action i"
    cmd /c "echo "yes" | pip install pygame -q -q -q --exists-action i"
    cmd /c "echo "yes" | pip install pycaw -q -q -q --exists-action i"
    cmd /c "echo "yes" | pip install comtypes -q -q -q --exists-action i"

    # Checks if fake folder exists, if not it'll create it.
    if (!(Test-Path -Path "$($env:TEMP)\jumpscare")) {
        New-Item -Path $($env:TEMP) -Name jumpscare -ItemType Directory -Force
    }    
    # Creates the script
    $jumpscareScript | Set-Content -Path "$($env:TEMP)\jumpscare\jumpscare.py"

    # Downloads the audio and video (if the don't exist yet)
    if (!(Test-Path -Path "$($env:TEMP)\jumpscare\js_video.mp4" -PathType Leaf)) {
        Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1s05xleLbvTAPvPqZ4eA0lMznq6GNv0FS&export=download" -OutFile "$($env:TEMP)\jumpscare\js_video.mp4"
    }
    if (!(Test-Path -Path "$($env:TEMP)\jumpscare\js_video.mp3" -PathType Leaf -IsValid)) {
        Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1ff7O0DQD1PqvKC1l9tfxRAx3RieQbNBm&export=download" -OutFile "$($env:TEMP)\jumpscare\js_audio.mp3"
    }

    # Run jumpscare script
    python "$($env:TEMP)\jumpscare\jumpscare.py"
}
else {
    Write-Host "Please install the latest version of Python to continue."
}
