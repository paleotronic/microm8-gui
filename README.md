# microm8-gui
GUI for the microM8 Apple II Emulator https://paleotronic.com/microm8/

Recently we’ve had requests from users for both an API (an interface for controlling our microM8 Apple II emulator externally) and a GUI (a graphical user-interface native to the host operating system).

The lack of a native GUI has always been an issue for users: microM8 is designed using a cross-platform OpenGL framework called GLFW, but GLFW offers little in the way of UI controls. Also, an API would allow people to automate emulation functions, for example to test .WOZ-format disks created with Applesauce.

We realised that we could kill two birds with one stone – we could build a GUI “frontend” application, and then have it control microM8. For efficiency, we used a cross-platform GUI development kit called Lazarus, which is based on FreePascal. 

Now the GUI is not perfect: because the GUI and microM8 are two separate applications, there can be the occasional issue keeping them synchronised, especially if you swap between multiple applications. But if you’re using microM8+GUI alone or on its own screen then they seem to generally behave themselves. Also, while the Lazarus framework is very cool, it’s not perfect either. But we felt we had got it to a point where it would be usable for most users, and give those who are less comfortable using microM8 ‘s keyboard-based interface another option.

And the GUI serves as a great example of what you can do with the API! The microM8 GUI is GPLv2 licensed.
