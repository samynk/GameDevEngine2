#include <ctime>
#include "GameClassName.h"

#ifdef WIN32
void StartHeapControl();
#endif

int main( int argc, char *argv[] )
{
	srand(static_cast<unsigned int>(time(nullptr)));

#ifdef WIN32
	StartHeapControl();
#endif

	GameClassName* pGame{ new GameClassName{ Window{ "Project name - Name, first name - 1DAEXX", 846.f , 500.f } } };
	pGame->Run();
	delete pGame;

	return 0;
}


// only legacy platforms need to run this
#ifdef _WIN32
void StartHeapControl()
{
#if defined(DEBUG) | defined(_DEBUG)
	// Notify user if heap is corrupt
	HeapSetInformation(NULL, HeapEnableTerminationOnCorruption, NULL, 0);

	// Report detected leaks when the program exits
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);

	// Set a breakpoint on the specified object allocation order number
	//_CrtSetBreakAlloc( 156 );
#endif
}
#endif
