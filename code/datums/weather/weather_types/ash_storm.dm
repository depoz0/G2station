//Ash storms happen frequently on lavaland. They heavily obscure vision, and cause high fire damage to anyone caught outside.
/datum/weather/ash_storm
	name = "пепельная буря"
	desc = "Интенсивный атмосферный шторм поднимает пепел с поверхности планеты и обрушивает его на все вокруг, нанося сильный урон от огня незащищенным слоям населения."

	telegraph_message = "<span class='boldwarning'>Жуткий стон поднимается от ветра. Куски горящего пепла чернеют на горизонте. Ищите укрытие.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_ash"

	weather_message = "<span class='userdanger'><i>Вокруг вас клубятся тлеющие облака палящего пепла! Зайдите внутрь!</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "ash_storm"

	end_message = "<span class='boldannounce'>Пронзительный ветер уносит последние остатки пепла и стихает до своего обычного воя. Теперь можно смело выходить наружу.</span>"
	end_duration = 300
	end_overlay = "light_ash"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_ASHSTORM

	immunity_type = TRAIT_ASHSTORM_IMMUNE

	probability = 90

	barometer_predictable = TRUE
	var/list/weak_sounds = list()
	var/list/strong_sounds = list()

/datum/weather/ash_storm/telegraph()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(place.outdoors)
			weak_sounds[place] = /datum/looping_sound/weak_outside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_outside_ashstorm
		else
			weak_sounds[place] = /datum/looping_sound/weak_inside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_inside_ashstorm
		CHECK_TICK

	//We modify this list instead of setting it to weak/stron sounds in order to preserve things that hold a reference to it
	//It's essentially a playlist for a bunch of components that chose what sound to loop based on the area a player is in
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/ash_storm/start()
	GLOB.ash_storm_sounds -= weak_sounds
	GLOB.ash_storm_sounds += strong_sounds
	return ..()

/datum/weather/ash_storm/wind_down()
	GLOB.ash_storm_sounds -= strong_sounds
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/ash_storm/can_weather_act(mob/living/mob_to_check)
	. = ..()
	if(!. || !ishuman(mob_to_check))
		return
	var/mob/living/carbon/human/human_to_check = mob_to_check
	if(human_to_check.get_thermal_protection() >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return FALSE

/datum/weather/ash_storm/weather_act(mob/living/victim)
	victim.adjustFireLoss(4, required_bodytype = BODYTYPE_ORGANIC)

/datum/weather/ash_storm/end()
	GLOB.ash_storm_sounds -= weak_sounds
	for(var/turf/open/misc/asteroid/basalt/basalt as anything in GLOB.dug_up_basalt)
		if(!(basalt.loc in impacted_areas) || !(basalt.z in impacted_z_levels))
			continue
		basalt.refill_dug()
	return ..()

//Emberfalls are the result of an ash storm passing by close to the playable area of lavaland. They have a 10% chance to trigger in place of an ash storm.
/datum/weather/ash_storm/emberfall
	name = "углепад"
	desc = "Проходящая пепельная буря усыпает окрестности безвредными угольками."

	weather_message = "<span class='notice'>Мягкие угли падают вокруг вас, как гротескный снег. Кажется, что буря прошла мимо вас...</span>"
	weather_overlay = "light_ash"

	end_message = "<span class='notice'>Падение угля замедляется и прекращается. Еще один слой затвердевшей сажи на базальте под ногами.</span>"
	end_sound = null

	aesthetic = TRUE

	probability = 10
