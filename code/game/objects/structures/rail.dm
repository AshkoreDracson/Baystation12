/obj/structure/rail
	icon = 'icons/nienhaus/rail.dmi'
	layer = ABOVE_WINDOW_LAYER
	plane = ABOVE_HUMAN_PLANE
	name = "rail"
	desc = "A metal lattice that prevents you from falling."
	density = 1
	anchored = 1
	flags = CONDUCT
	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(istype(mover) && mover.checkpass(PASSGLASS))
			return 1
		if(get_dir(loc, target) == dir) //Make sure looking at appropriate border
			if(air_group) return 0
			return !density
		else
			return 1

	CheckExit(atom/movable/mover as mob|obj, turf/target as turf)
		if(istype(mover) && mover.checkpass(PASSGLASS))
			return 1
		if(get_dir(loc, target) == dir)
			return !density
		else
			return 1


/obj/structure/rail/yellow
	icon_state = "yellow"

/obj/structure/rail/black
	icon_state = "black"