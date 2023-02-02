add_library(
Core
#precompiled header
pch.h
pch.cpp
#Math
Vector2f.h
Vector2f.cpp
Matrix2x3.h
Matrix2x3.cpp
#Engine
Texture.h
Texture.cpp
BaseGame.h
BaseGame.cpp
SoundEffect.h
SoundEffect.cpp
SoundStream.h
SoundStream.cpp
structs.h
structs.cpp
SVGParser.h
SVGParser.cpp
utils.h
utils.cpp
)

source_group( "Math code" 
FILES
	Vector2f.h
	Vector2f.cpp
	Matrix2x3.h
	Matrix2x3.cpp
)

source_group ( "Engine code" 
FILES
Texture.h
Texture.cpp
Core.h
Core.cpp
SoundEffect.h
SoundEffect.cpp
SoundStream.h
SoundStream.cpp
structs.h
structs.cpp
SVGParser.h
SVGParser.cpp
utils.h
utils.cpp
)

set(GAME_INCLUDE_PATH ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
