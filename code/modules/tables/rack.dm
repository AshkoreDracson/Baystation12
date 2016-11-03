/obj/structure/table/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/nienhaus/rack.dmi'
	icon_state = "1"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

/obj/structure/table/rack/New()
	..()
	verbs -= /obj/structure/table/verb/do_flip
	verbs -= /obj/structure/table/proc/do_put

/obj/structure/table/rack/initialize()
	auto_align()
	..()

/obj/structure/table/rack/update_connections()
	return

/obj/structure/table/rack/update_desc()
	return

/obj/structure/table/rack/update_icon()
	return

/obj/structure/table/rack/holorack/dismantle(obj/item/weapon/wrench/W, mob/user)
	user << "<span class='warning'>You cannot dismantle \the [src].</span>"
	return
