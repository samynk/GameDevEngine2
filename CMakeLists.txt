cmake_minimum_required(VERSION 3.16)
   
project(GameEngine)

include(./cmake/dae/dae_utils.cmake)
include(./cmake/dae/buildweb.cmake)

message("CMake system : ${CMAKE_SYSTEM_NAME}" )
add_subdirectory(Libraries/Engine)
add_subdirectory(Libraries/Test)
if(EMSCRIPTEN)
	set(GL_COMPAT OFF CACHE BOOL 
	"Run with OpenGL 3.3 (and support legacy fixed function as well)")
	set(CMAKE_CXX_FLAGS "-g -fPIC")
	set(CMAKE_EXECUTABLE_SUFFIX ".html")
	SetupEmscripten(Core)
	SetupEmscripten(CoreTest)
else()
	DefineLibraries()
endif()



message("Libraries defined")
message("Project location: ${CMAKE_SOURCE_DIR}/projects.cmake")

if (EXISTS "${CMAKE_SOURCE_DIR}/projects.cmake")
	message("projects.cmake exists")
	include(./projects.cmake)
endif()

include(InstallRequiredSystemLibraries)
