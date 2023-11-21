/datum/round_event_control/mice_migration
	name = "Миграция мышей"
	typepath = /datum/round_event/mice_migration
	weight = 10
	category = EVENT_CATEGORY_ENTITIES
	description = "Прибывает огромное количество мышей, а возможно, и сам Крысиный Король."

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("космической бурей", "сокращением бюджета", "Рагнарёк",
		"холодным космосом", "\[REDACTED\]", "изменением климата",
		"невезением")
	var/plural = pick("несколько", "куча", "стая", "целый табор",
		"не более чем [maximum_mice]")
	var/name = pick("грызунов", "мышей", "пищащих вредителей",
		"млекопитающих, питающимися проводами", "\[REDACTED\]", "паразитов, истощающих энергетические ресурсы")
	var/movement = pick("мигрировали", "приползли", "спустились", "выползли")
	var/location = pick("эксплуатационные туннели", "зоны обслуживания",
		"\[REDACTED\]", "место со всеми этими сочными проводами")

	priority_announce("В связи с [cause], [plural] [name] [movement] \
		в [location].", "Миграционное предупреждение",
		'sound/creatures/mousesqueek.ogg')

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
