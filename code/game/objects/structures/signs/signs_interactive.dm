/obj/structure/sign/clock
	name = "настенные часы"
	desc = "Это обычные настенные часы, показывающие как местное стандартное время Коалиции, так и галактическое координированное время. Идеально подходят для того, чтобы смотреть на них, а не работать."
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("Текущее время CST (местное): [station_time_timestamp()].")
	. += span_info("Текущее TCT (галактическое) время: [time2text(world.realtime, "hh:mm:ss")].")

/obj/structure/sign/calendar
	name = "настенный календарь"
	desc = "Это старый добрый настенный календарь. Конечно, он может устареть с развитием современных технологий, но все равно трудно представить себе офис без такого календаря."
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("Текущая дата: [time2text(world.realtime, "DDD, MMM DD")], [CURRENT_STATION_YEAR].")
	if(length(GLOB.holidays))
		. += span_info("Events:")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
