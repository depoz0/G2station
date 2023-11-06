/datum/round_event_control/anomaly/anomaly_bluespace
	name = "Аномалия: пространство"
	typepath = /datum/round_event/anomaly/anomaly_bluespace

	max_occurrences = 1
	weight = 15
	description = "Эта аномалия случайным образом телепортирует все предметы и мобов на большой территории."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 2

/datum/round_event/anomaly/anomaly_bluespace
	start_when = ANOMALY_START_MEDIUM_TIME
	announce_when = ANOMALY_ANNOUNCE_MEDIUM_TIME
	anomaly_path = /obj/effect/anomaly/bluespace

/datum/round_event/anomaly/anomaly_bluespace/announce(fake)
	priority_announce("Обнаружена нестабильность пространства на [ANOMALY_ANNOUNCE_MEDIUM_TEXT] [impact_area.name].", "Предупреждение об аномалиях")
