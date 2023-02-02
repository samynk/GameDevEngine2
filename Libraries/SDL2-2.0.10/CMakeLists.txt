#Programming 2 framework : SDL2 library
add_library(SDL INTERFACE)
set(SDLIncludeDir "${CMAKE_CURRENT_SOURCE_DIR}/include" PARENT_SCOPE)
set(SDLLibraryDir "${CMAKE_CURRENT_SOURCE_DIR}/lib/x64" PARENT_SCOPE)
