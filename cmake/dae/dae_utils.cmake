function(DefineLibraries)
message("Current root directory : ${CMAKE_SOURCE_DIR}")
set( SDL2_PATH "${CMAKE_SOURCE_DIR}/Libraries/SDL2-2.0.10")
set( SDL2_IMAGE_PATH "${CMAKE_SOURCE_DIR}/Libraries/SDL2_image-2.0.5")
set( SDL2_TTF_PATH "${CMAKE_SOURCE_DIR}/Libraries/SDL2_ttf-2.0.15")
set( SDL2_MIXER_PATH "${CMAKE_SOURCE_DIR}/Libraries/SDL2_mixer-2.0.4")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/sdl2")
# Add SDL2 library
find_package(SDL2 REQUIRED)
target_link_libraries(Core SDL2::Main)
# Add SDL2_image library
find_package(SDL2_image REQUIRED)
target_link_libraries(Core SDL2::Image)
# Add SDL2_ttf library
find_package(SDL2_ttf REQUIRED)
target_link_libraries(Core SDL2::TTF)
# Add SDL2_net library
#find_package(SDL2_net REQUIRED)
#target_link_libraries(${PROJECT_NAME} SDL2::Net)
# Add SDL2_mixer library
find_package(SDL2_mixer REQUIRED)



target_link_libraries(Core SDL2::Mixer)


find_package(OpenGL REQUIRED) 
target_link_libraries(Core OpenGL::GL)

include(FetchContent)
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


function(DefineGameProject projectName)
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
	string(REPLACE "GameClassName" ${projectName} MainReplaced "${Main}")
	file(WRITE "${projectDir}/main.cpp" "${MainReplaced}")
endif()

if(NOT EXISTS "${projectDir}/${projectName}.h")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/GameTemplate.h" GameHeader )
	string(REPLACE "GameClassName" ${projectName} GameHeaderReplaced "${GameHeader}")
	file(WRITE "${projectDir}/${projectName}.h" "${GameHeaderReplaced}")
endif()

if(NOT EXISTS "${projectDir}/${projectName}.cpp")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/GameTemplate.cpp" GameCpp )
	string(REPLACE "GameClassName" ${projectName} GameCppReplaced "${GameCpp}")
	file(WRITE "${projectDir}/${projectName}.cpp" "${GameCppReplaced}")
endif()

if(NOT EXISTS "${projectDir}/CMakeLists.txt")
	file(READ "${CMAKE_SOURCE_DIR}/cmake/dae/cmakeprojecttemplate.txt" ProjectTemplate )
	string(REPLACE "projectName" ${projectName} ProjectTemplateReplaced "${ProjectTemplate}")
	file(WRITE "${projectDir}/CMakeLists.txt" "${ProjectTemplateReplaced}")
endif()

add_subdirectory(${projectDir})


endfunction()