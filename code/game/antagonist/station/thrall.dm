GLOBAL_DATUM_INIT(thralls, /datum/antagonist/thrall, new)

/datum/antagonist/thrall
	role_text = "Thrall"
	role_text_plural = "Thralls"
	welcome_text = "Your mind is no longer solely your own..."
	id = MODE_THRALL
	flags = ANTAG_IMPLANT_IMMUNE

	var/list/thrall_controllers = list()

/datum/antagonist/thrall/create_objectives(datum/mind/player)
	var/mob/living/controller = thrall_controllers["\ref[player]"]
	if(!controller)
		return // Someone is playing with buttons they shouldn't be.
	var/datum/objective/obey = new
	obey.owner = player
	obey.explanation_text = "Obey your master, [controller.real_name], in all things."
	player.objectives |= obey

/datum/antagonist/thrall/add_antagonist(datum/mind/player, ignore_role, do_not_equip, move_to_spawn, do_not_announce, preserve_appearance, mob/new_controller)
	if(!new_controller)
		return 0
	. = ..()
	if(.) thrall_controllers["\ref[player]"] = new_controller

/datum/antagonist/thrall/greet(datum/mind/player)
	. = ..()
	var/mob/living/controller = thrall_controllers["\ref[player]"]
	if(controller)
		to_chat(player, "<span class='danger'>Your will has been subjugated by that of [controller.real_name]. Obey them in all things.</span>")
