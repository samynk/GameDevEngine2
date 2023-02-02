function addsdllibrary()
set( SDL2_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Libraries/SDL2-2.0.10")
set( SDL2_IMAGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Libraries/SDL2_image-2.0.5")
set( SDL2_TTF_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Libraries/SDL2_ttf-2.0.15")
set( SDL2_MIXER_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Libraries/SDL2_mixer-2.0.4")
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/sdl2)
# Add SDL2 library
find_package(SDL2 REQUIRED)
# Add SDL2_image library
find_package(SDL2_image REQUIRED)
# Add SDL2_ttf library
find_package(SDL2_ttf REQUIRED)
# Add SDL2_net library
#find_package(SDL2_net REQUIRED)
#target_link_libraries(${PROJECT_NAME} SDL2::Net)
# Add SDL2_mixer library
find_package(SDL2_mixer REQUIRED)
endfunction()