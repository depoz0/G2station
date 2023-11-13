/datum/round_event_control/communications_blackout
	name = "Отключение связи"
	typepath = /datum/round_event/communications_blackout
	weight = 30
	category = EVENT_CATEGORY_ENGINEERING
	description = "Сильно поражает все телекоммуникационные устройства, блокируя на некоторое время связь."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 3

/datum/round_event/communications_blackout
	announce_when = 1

/datum/round_event/communications_blackout/announce(fake)
	var/alert = pick( "Обнаружены ионосферные аномалии. Ожидается временный отказ телекоммуникаций. Пожалуйста, свяжитесь с ва*%fj00)`5vc-BZZT",
		"Обнаружены ионосферные аномалии. Ожидается временный отказ телекоммуник*3mga;b4;'1v¬-BZZZT",
		"Обнаружены ионосферные аномалии. Ожидается временный отк#MCi46:5.;@63-BZZZZT",
		"Обнаружены ионосферные анома'fZ\\kg5_0-BZZZZZT",
		"Обнаружены ио:%£ MCayj^j<.3-BZZZZZZT",
		"#4nd%;f4y6,>£%-BZZZZZZZT",
	)

	for(var/mob/living/silicon/ai/A in GLOB.ai_list) //AIs are always aware of communication blackouts.
		to_chat(A, "<br>[span_warning("<b>[alert]</b>")]<br>")

	if(prob(30) || fake) //most of the time, we don't want an announcement, so as to allow AIs to fake blackouts.
		priority_announce(alert, "Предупреждение об аномалии")


/datum/round_event/communications_blackout/start()
	for(var/obj/machinery/telecomms/T in GLOB.telecomms_list)
		T.emp_act(EMP_HEAVY)
