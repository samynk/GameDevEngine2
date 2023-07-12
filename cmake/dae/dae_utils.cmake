function(DefineLibraries)
include(FetchContent)
Set(FETCHCONTENT_QUIET FALSE)

if (WIN32)
	message("Building for Windows")
	FetchContent_Declare(
	  SDL2
	  URL https://www.libsdl.org/release/SDL2-devel-2.26.3-VC.zip 
	  DOWNLOAD_NO_PROGRESS ON
	  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads 
	)
	FetchContent_MakeAvailable(SDL2)
	list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/_deps/sdl2-src/cmake")

	FetchContent_Declare(
	  SDL2_image
	  URL https://github.com/libsdl-org/SDL_image/releases/download/release-2.6.3/SDL2_image-devel-2.6.3-VC.zip
	  DOWNLOAD_NO_PROGRESS ON
	  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads 
	)
	FetchContent_MakeAvailable(SDL2_image)
	list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/_deps/sdl2_image-src/cmake")

	FetchContent_Declare(
	  SDL2_ttf
	  URL https://github.com/libsdl-org/SDL_ttf/releases/download/release-2.20.0/SDL2_ttf-devel-2.20.0-VC.zip
	  DOWNLOAD_NO_PROGRESS ON
	  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads 
	)
	FetchContent_MakeAvailable(SDL2_ttf)
	list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/_deps/sdl2_ttf-src/cmake")

	FetchContent_Declare(
	  SDL2_mixer
	  URL https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.3/SDL2_mixer-devel-2.6.3-VC.zip
	  DOWNLOAD_NO_PROGRESS ON
	  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads 
	)
	FetchContent_MakeAvailable(SDL2_mixer)
	list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/_deps/sdl2_mixer-src/cmake")
else()
	list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/sdl2)
endif()

if (NOT EMSCRIPTEN)
message("finding packages for Windows and Linux")
find_package(SDL2 REQUIRED)
find_package(SDL2_image REQUIRED)
find_package(SDL2_ttf REQUIRED)
find_package(SDL2_mixer REQUIRED)

endif()
find_package(OpenGL REQUIRED)

if (WIN32)
target_link_libraries(Core 
	${SDL2_LIBRARIES}
	SDL2_image::SDL2_image
	SDL2_ttf::SDL2_ttf
	SDL2_mixer::SDL2_mixer
	OpenGL::GL
)
else()
target_link_libraries(Core 
	${SDL2_LIBRARIES}
	SDL2::Image
	SDL2::TTF
	SDL2::Mixer
	#OpenGL::GL
)
endif()

message("Image libraries: ${SDL2_IMAGE_LIBRARIES}")

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_target_properties(CoreTest Core gtest gtest_main gmock gmock_main PROPERTIES FOLDER HiddenTargets)


endfunction()


function(DefineGameProject projectName gameClassName)
set(projectDir "${CMAKE_SOURCE_DIR}/Projects/${projectName}")

if (EXISTS "${projectDir}")
	# don't regenerate the project
	add_subdirectory(${projectDir})
	return()
endif()

file(MAKE_DIRECTORY ${projectDir})
file(MAKE_DIRECTORY "${projectDir}/Resources")

if(NOT EXISTS "${projectDir}/main.cpp")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/main.cpp" Main )
	string(REPLACE "GameClassName" ${gameClassName} MainReplaced "${Main}")
	file(WRITE "${projectDir}/main.cpp" "${MainReplaced}")
endif()

if(NOT EXISTS "${projectDir}/${gameClassName}.h")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/GameTemplate.h" GameHeader )
	string(REPLACE "GameClassName" ${gameClassName} GameHeaderReplaced "${GameHeader}")
	file(WRITE "${projectDir}/${gameClassName}.h" "${GameHeaderReplaced}")
endif()

if(NOT EXISTS "${projectDir}/${gameClassName}.cpp")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/GameTemplate.cpp" GameCpp )
	string(REPLACE "GameClassName" ${gameClassName} GameCppReplaced "${GameCpp}")
	file(WRITE "${projectDir}/${gameClassName}.cpp" "${GameCppReplaced}")
endif()

if(NOT EXISTS "${projectDir}/CMakeLists.txt")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/cmakeprojecttemplate.txt" ProjectTemplate )
	string(REPLACE "projectName" ${projectName} ProjectTemplateReplaced "${ProjectTemplate}")
	string(REPLACE "gameClassName" ${gameClassName} ProjectTemplateReplaced "${ProjectTemplateReplaced}")
	file(WRITE "${projectDir}/CMakeLists.txt" "${ProjectTemplateReplaced}")
endif()

add_subdirectory(${projectDir})

if (Emscripten)
	SetupEmscripten(projectName)
endif()
endfunction()