#if !defined(USING_MAP_DATUM)

	#include "curie_areas.dm"
	#include "curie_shuttles.dm"
	#include "curie_unit_testing.dm"

	#include "../shared/exodus_torch_areas.dm"
	#include "../exodus/exodus_areas.dm"

	#include "curie-1.dmm"
	#include "curie-2.dmm"
	#include "curie-3.dmm"
	#include "curie-4.dmm"
	#include "curie-5.dmm"
	#include "curie-6.dmm"

	#include "../../code/modules/lobby_music/absconditus.dm"
	#include "../../code/modules/lobby_music/clouds_of_fire.dm"
	#include "../../code/modules/lobby_music/endless_space.dm"
	#include "../../code/modules/lobby_music/dilbert.dm"
	#include "../../code/modules/lobby_music/space_oddity.dm"
	#include "../../code/modules/lobby_music/hardcorner.dm"
	#include "../../code/modules/lobby_music/spessbenzaie.dm"

	#define USING_MAP_DATUM /datum/map/curie

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Curie
#endif
