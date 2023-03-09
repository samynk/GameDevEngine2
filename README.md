# GameDevEngine2
2D Engine for first year students of the game development major of Digital Arts and Entertainment (DAE)

# Getting started

The cmake build works on Linux and Windows. 
To add an executable game engine, create a file **projects.cmake** in the root folder and
add game projects in the following way:

DefineGameProject("GameProject1")

A new game project will be made in the subfolder GameProject1 and with the dependencies correctly set.
