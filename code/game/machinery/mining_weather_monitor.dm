/// Wall mounted mining weather tracker
/obj/machinery/mining_weather_monitor
	name = "барометрический монитор"
	desc = "Устройство, отслеживающее данные об атмосфере в горнодобывающих местах. Выдает предупреждения о приближающихся погодных условиях."
	icon = 'icons/obj/miningradio.dmi'
	icon_state = "wallmount"
	light_power = 1
	light_range = 1.6

/obj/machinery/mining_weather_monitor/Initialize(mapload, ndir, nbuild)
	. = ..()
	AddComponent( \
		/datum/component/weather_announcer, \
		state_normal = "wallgreen", \
		state_warning = "wallyellow", \
		state_danger = "wallred", \
	)

/obj/machinery/mining_weather_monitor/update_overlays()
	. = ..()
	if((machine_stat & BROKEN) || !powered())
		return
	. += emissive_appearance(icon, "emissive", src)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/mining_weather_monitor, 28)
