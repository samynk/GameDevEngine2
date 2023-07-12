function(SetupEmscripten TARGET_NAME)
message("Building for emscripten")
	if(GL_COMPAT)
		target_compile_definitions(${TARGET_NAME} PUBLIC GL_COMPAT)
		target_link_libraries(${TARGET_NAME} PUBLIC -sWASM=1 -sMAX_WEBGL_VERSION=2 -sMIN_WEBGL_VERSION=2)
	else()
		# we're using legacy fixed function GL2
		target_link_libraries(${TARGET_NAME} PUBLIC -sLEGACY_GL_EMULATION=1 -sGL_UNSAFE_OPTS=1)
	endif()

	target_compile_options(${TARGET_NAME} PUBLIC -sUSE_SDL=2 -sUSE_SDL_IMAGE=2 -sUSE_SDL_TTF=2 -sUSE_SDL_MIXER=2 -g -Wno-switch)
    target_link_libraries(${TARGET_NAME} PUBLIC -sLEGACY_GL_EMULATION=1 -sGL_UNSAFE_OPTS=1 -sERROR_ON_UNDEFINED_SYMBOLS=0 -sUSE_SDL=2 -sUSE_SDL_IMAGE=2 -sUSE_SDL_TTF=2 -sUSE_SDL_MIXER=2)

	set_target_properties(${TARGET_NAME}
		PROPERTIES LINK_FLAGS 
		"-s ASSERTIONS -s GL_ASSERTIONS -s GL_DEBUG -s DEMANGLE_SUPPORT=1 -s OFFSCREEN_FRAMEBUFFER=1 -s ALLOW_MEMORY_GROWTH -s EXIT_RUNTIME=1 -s SDL2_IMAGE_FORMATS='[\"png\"]' --preload-file \"${CMAKE_SOURCE_DIR}/resources@/\"")
endfunction()