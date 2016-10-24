var/list/light_over_cache = list()

/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = DARK_PLANE

	layer = 1
	//layer 1 = base plane layer
	//layer 2 = base shadow templates
	//layer 3 = wall lighting overlays
	//layer 4 = light falloff overlay

	appearance_flags = KEEP_TOGETHER
	icon = null
	invisibility = SEE_INVISIBLE_NOLIGHTING
	pixel_x = -64
	pixel_y = -64
	glide_size = 32
	blend_mode = BLEND_ADD

	var/current_power = 1
	var/atom/movable/holder
	var/point_angle
	var/list/affecting_turfs = list()

/obj/light/New(var/newholder)
	holder = newholder
	if(istype(holder, /atom))
		var/atom/A = holder
		light_range = A.light_range
		light_color = A.light_color
		color = light_color
	..(get_turf(holder))

/obj/effect/light/Destroy()

	moved_event.unregister(holder, src)
	dir_set_event.unregister(holder, src)
	destroyed_event.unregister(holder, src)

	transform = null
	appearance = null
	overlays = null

	if(holder)
		moved_event.unregister(holder, src)
		dir_set_event.unregister(holder, src)
		destroyed_event.unregister(holder, src)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	for(var/thing in affecting_turfs)
		var/turf/T = thing
		T.lumcount = -1
		T.affecting_lights -= src
	affecting_turfs.Cut()
	return .. ()

/atom/set_dir()
	. = ..()
	if(light_obj)
		light_obj.follow_holder_dir()

/mob/living/carbon/human/set_dir()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.set_dir(dir)

/mob/living/carbon/human/Move()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.light_obj.follow_holder()

/mob/living/carbon/human/forceMove()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.light_obj.follow_holder()

/obj/effect/light/initialize()
	..()
	follow_holder_dir()
	follow_holder()
	moved_event.register(holder, src, /obj/light/proc/follow_holder)
	dir_set_event.register(holder, src, /obj/light/proc/follow_holder_dir)
	destroyed_event.register(holder, src, /obj/light/proc/destroy_self)

// Would be nice if we didn't need a qdel() wrapper for the event system.
/obj/light/proc/destroy_self()
	qdel(src)

// Applies power value to size (via Scale()) and updates the current rotation (via Turn())
// angle for directional lights. This is only ever called before cast_light() so affected turfs
// are updated elsewhere.
/obj/light/proc/update_transform(var/newrange)
	if(!isnull(newrange) && current_power != newrange)
		// Update affected turfs based on new size.
		current_power = newrange

// Orients the light to the holder's (or the holder's holder) current dir.
// Also updates rotation for directional lights when appropriate.
/obj/effect/light/proc/follow_holder_dir()

	if(dir != holder.dir)
		set_dir(holder.dir)
/*
	if(is_directional_light())
		var/last_angle = point_angle
		switch(dir)
			if(NORTH)     point_angle = 90
			if(SOUTH)     point_angle = -90
			if(EAST)      point_angle = -180
			if(WEST)      point_angle = 0
			if(NORTHEAST) point_angle = 135
			if(NORTHWEST) point_angle = 45
			if(SOUTHEAST) point_angle = -135
			if(SOUTHWEST) point_angle = -45
			else          point_angle = null
		if(last_angle != point_angle)
			update_transform()
			cast_light()
*/
// Moves the light overlay to the holder's turf and updates bleeding values accordingly.
/obj/effect/light/proc/follow_holder()
	if(holder && holder.loc)
		if(holder.loc.loc && ismob(holder.loc))
			forceMove(holder.loc.loc)
		else
			forceMove(holder.loc)
	cast_light()

/obj/effect/light/proc/is_directional_light()
	return (holder.light_type == LIGHT_DIRECTIONAL)
