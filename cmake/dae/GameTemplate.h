#pragma once
#include "BaseGame.h"
class GameClassName : public BaseGame
{
public:
	explicit GameClassName( const Window& window );
	GameClassName(const GameClassName& other) = delete;
	GameClassName& operator=(const GameClassName& other) = delete;
	GameClassName( GameClassName&& other) = delete;
	GameClassName& operator=(GameClassName&& other) = delete;
	~GameClassName();

	void Update( float elapsedSec ) override;
	void Draw( ) const override;

	// Event handling
	void ProcessKeyDownEvent( const SDL_KeyboardEvent& e ) override;
	void ProcessKeyUpEvent( const SDL_KeyboardEvent& e ) override;
	void ProcessMouseMotionEvent( const SDL_MouseMotionEvent& e ) override;
	void ProcessMouseDownEvent( const SDL_MouseButtonEvent& e ) override;
	void ProcessMouseUpEvent( const SDL_MouseButtonEvent& e ) override;

private:

	// FUNCTIONS
	void Initialize( );
	void Cleanup( );
	void ClearBackground( ) const;
};