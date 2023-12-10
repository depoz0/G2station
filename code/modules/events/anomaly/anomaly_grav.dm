/datum/round_event_control/anomaly/anomaly_grav
	name = "Аномалия: гравитационная"
	typepath = /datum/round_event/anomaly/anomaly_grav

	max_occurrences = 5
	weight = 25
	description = "Эта аномалия бросает все вокруг."
	min_wizard_trigger_potency = 1
	max_wizard_trigger_potency = 3

/datum/round_event/anomaly/anomaly_grav
	start_when = ANOMALY_START_HARMFUL_TIME
	announce_when = ANOMALY_ANNOUNCE_HARMFUL_TIME
	anomaly_path = /obj/effect/anomaly/grav

/datum/round_event_control/anomaly/anomaly_grav/high
	name = "Аномалия: гравитационная (высокой интенсивности)"
	typepath = /datum/round_event/anomaly/anomaly_grav/high
	weight = 15
	max_occurrences = 1
	earliest_start = 20 MINUTES
	description = "Эта аномалия обладает интенсивным гравитационным полем и может вывести из строя гравитационный генератор."

/datum/round_event/anomaly/anomaly_grav/high
	start_when = ANOMALY_START_HARMFUL_TIME
	announce_when = ANOMALY_ANNOUNCE_HARMFUL_TIME
	anomaly_path = /obj/effect/anomaly/grav/high

/datum/round_event/anomaly/anomaly_grav/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.findValidArea()
	priority_announce("Гравитационная аномалия обнаружена на [ANOMALY_ANNOUNCE_HARMFUL_TEXT] [impact_area.name].", "Предупреждение об аномалиях" , ANNOUNCER_GRANOMALIES)
