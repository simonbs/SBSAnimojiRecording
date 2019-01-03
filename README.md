# SBSAnimojiRecording

Shows how Apples Animojis can be overlayed on a camera feed using ARKit. **NB: This is achieved in a hacky way.**

Videos are recorded using ReplayKit.

Tested on iPhone X and iPhone XS Max.

# Usage

- Clone the repository and run the app on a device that supports Animojis.
- To change the Animoji, you need to change the puppet name in [this line of code](https://github.com/simonbs/SBSAnimojiRecording/blob/master/SBSAnimojiRecording/Source/CameraViewController.m#L26). Supported puppet names are koala, monkey, dog, etc.

# Caveats

- It's super hacky.
- It relies on [magic numbers](https://github.com/simonbs/SBSAnimojiRecording/blob/master/SBSAnimojiRecording/Source/CameraViewController.m#L58-L68) for positioning the Animoji.
- It uses ugly [device checks](https://github.com/simonbs/SBSAnimojiRecording/blob/master/SBSAnimojiRecording/Source/CameraViewController.m#L58-L68).
- It's glitching when showing some Animojis.

# Notice

This project relies heavily on Apples private API and you should therefore not try to submit this code to App Store.
