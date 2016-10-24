/image/master_plane
	name = "master lighting plane"
	blend_mode = BLEND_MULTIPLY
	layer = 1

/obj/screen/plane/New(var/client/C)
	..()
	if(istype(C)) C.screen += src
	verbs.Cut()

/obj/screen/plane/master
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	mouse_opacity = 0
	plane = MASTER_PLANE

/image/dark_plane
	name = "darkness lighting plane"
	blend_mode = BLEND_ADD
	mouse_opacity = 0
	plane = DARK_PLANE // Just below the master plane.
	icon = 'icons/planar_lighting/over_dark.dmi'
	alpha = 25
	appearance_flags = RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	var/first_state_change = 1 // Used by global lighting.

/image/dark_plane/New()
	..()
	var/matrix/M = matrix()
	M.Scale(world.view*2.2)
	transform = M

/image/darkmask
	blend_mode = BLEND_SUBTRACT
	mouse_opacity = 0
	plane = DARK_PLANE
	icon = 'icons/planar_lighting/over_dark.dmi'
	appearance_flags = KEEP_TOGETHER
