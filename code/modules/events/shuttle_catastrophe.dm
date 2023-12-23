/datum/round_event_control/shuttle_catastrophe
	name = "Катастрофа шаттла"
	typepath = /datum/round_event/shuttle_catastrophe
	weight = 10
	max_occurrences = 1
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "Заменяет аварийный шаттл на случайный."
	admin_setup = list(/datum/event_admin_setup/warn_admin/shuttle_catastrophe, /datum/event_admin_setup/listed_options/shuttle_catastrophe)

/datum/round_event_control/shuttle_catastrophe/can_spawn_event(players, allow_magic = FALSE)
	. = ..()
	if(!.)
		return .

	if(SSshuttle.shuttle_purchased == SHUTTLEPURCHASE_FORCED)
		return FALSE //don't do it if its already been done
	if(istype(SSshuttle.emergency, /obj/docking_port/mobile/emergency/shuttle_build))
		return FALSE //don't undo manual player engineering, it also would unload people and ghost them, there's just a lot of problems
	if(EMERGENCY_AT_LEAST_DOCKED)
		return FALSE //don't remove all players when its already on station or going to centcom
	return TRUE

/datum/round_event/shuttle_catastrophe
	var/datum/map_template/shuttle/new_shuttle

/datum/round_event/shuttle_catastrophe/announce(fake)
	var/cause = pick("был атакован оперативниками [syndicate_name()]", "таинственным образом телепортировался", "взбунтовалась команда заправщиков",
		"был найден с украденными двигателями", "\[REDACTED\]", "улетел в закат и расплавился", "научился кое-чему у очень мудрой коровы и улетел сам по себе",
		"были устройства для клонирования", "инспектор перевел шаттл на задний ход, а не на парковку, в результате чего шаттл врезался в ангар")
	var/message = "Ваш аварийный шаттл [cause]. "

	if(SSshuttle.shuttle_insurance)
		message += "К счастью, страховка вашего шаттла покрыла расходы на ремонт!"
		if(SSeconomy.get_dep_account(ACCOUNT_CAR))
			message += " Вы получили бонус от [command_name()] за разумные траты."
	else
		message += "До дальнейшего уведомления вашим запасным шаттлом будет [new_shuttle.name]."
	priority_announce(message, "[command_name()] Spacecraft Engineering")

/datum/round_event/shuttle_catastrophe/setup()
	if(SSshuttle.shuttle_insurance || !isnull(new_shuttle)) //If an admin has overridden it don't re-roll it
		return
	var/list/valid_shuttle_templates = list()
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(!isnull(template.who_can_purchase) && template.credit_cost < INFINITY) //if we could get it from the communications console, it's cool for us to get it here
			valid_shuttle_templates += template
	new_shuttle = pick(valid_shuttle_templates)

/datum/round_event/shuttle_catastrophe/start()
	if(SSshuttle.shuttle_insurance)
		var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
		station_balance?.adjust_money(8000)
		return
	SSshuttle.shuttle_purchased = SHUTTLEPURCHASE_FORCED
	SSshuttle.unload_preview()
	SSshuttle.existing_shuttle = SSshuttle.emergency
	SSshuttle.action_load(new_shuttle, replace = TRUE)
	log_shuttle("Shuttle Catastrophe set a new shuttle, [new_shuttle.name].")

/datum/event_admin_setup/warn_admin/shuttle_catastrophe
	warning_text = "Это разгрузит пристыкованный аварийный шаттл и уничтожит все, что в нем находится. Продолжить?"
	snitch_text = "has forced a shuttle catastrophe while a shuttle was already docked."

/datum/event_admin_setup/warn_admin/shuttle_catastrophe/should_warn()
	return EMERGENCY_AT_LEAST_DOCKED || istype(SSshuttle.emergency, /obj/docking_port/mobile/emergency/shuttle_build)

/datum/event_admin_setup/listed_options/shuttle_catastrophe
	input_text = "Выбрать конкретный шаттл?"
	normal_run_option = "Случайный шаттл"

/datum/event_admin_setup/listed_options/shuttle_catastrophe/get_list()
	var/list/valid_shuttle_templates = list()
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(!isnull(template.who_can_purchase) && template.credit_cost < INFINITY) //Even admins cannot force the cargo shuttle to act as an escape shuttle
			valid_shuttle_templates += template
	return valid_shuttle_templates

/datum/event_admin_setup/listed_options/shuttle_catastrophe/apply_to_event(datum/round_event/shuttle_catastrophe/event)
	event.new_shuttle = chosen
