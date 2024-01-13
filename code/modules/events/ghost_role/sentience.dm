GLOBAL_LIST_INIT(high_priority_sentience, typecacheof(list(
	/mob/living/basic/bat,
	/mob/living/basic/butterfly,
	/mob/living/basic/carp/pet/cayenne,
	/mob/living/basic/chicken,
	/mob/living/basic/cow,
	/mob/living/basic/goat,
	/mob/living/basic/lizard,
	/mob/living/basic/mouse/brown/tom,
	/mob/living/basic/parrot,
	/mob/living/basic/pet,
	/mob/living/basic/pig,
	/mob/living/basic/rabbit,
	/mob/living/basic/sheep,
	/mob/living/basic/sloth,
	/mob/living/basic/snake,
	/mob/living/basic/spider/giant/sgt_araneus,
	/mob/living/simple_animal/bot/secbot/beepsky,
	/mob/living/simple_animal/hostile/retaliate/goose/vomit,
	/mob/living/simple_animal/pet,
)))

/datum/round_event_control/sentience
	name = "Random Human-level Intelligence"
	typepath = /datum/round_event/ghost_role/sentience
	weight = 10
	category = EVENT_CATEGORY_FRIENDLY
	description = "An animal or robot becomes sentient!"
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 7


/datum/round_event/ghost_role/sentience
	minimum_required = 1
	role_name = "random animal"
	var/animals = 1
	var/one = "один"
	fakeable = TRUE

/datum/round_event/ghost_role/sentience/announce(fake)
	var/sentience_report = ""

	var/data = pick("сканирование наших сенсоров дальнего действия", "наши сложные вероятностные модели", "наше всемогущество", "коммуникационный трафик на вашей станции", "обнаруженные нами выбросы энергии", "\[ОТРЕДАКТИРОВАНО\]")
	var/pets = pick("животных/ботов", "ботов/животных", "питомцов", "простых животных", "низших форм жизни", "\[REDACTED\]")
	var/strength = pick("уровне человека", "среднем уровне", "уровне ящерицы", "уровне охраны", "уровне начальства", "уровне клоуна", "низком уровне", "очень низком уровне", "\[ОТРЕДАКТИРОВАНО\]")

	sentience_report += "Основываясь на [data], мы считаем, что [one] из [pets] на станции развили интеллект на [strength] и способность к общению."

	priority_announce(sentience_report,"[command_name()] объявление со средним приоритетом")

/datum/round_event/ghost_role/sentience/spawn_role()
	var/list/mob/dead/observer/candidates
	candidates = SSpolling.poll_ghost_candidates(check_jobban = ROLE_SENTIENCE, role = ROLE_SENTIENCE, pic_source = /obj/item/slimepotion/slime/sentience, role_name_text = role_name)

	// find our chosen mob to breathe life into
	// Mobs have to be simple animals, mindless, on station, and NOT holograms.
	// prioritize starter animals that people will recognise


	var/list/potential = list()

	var/list/hi_pri = list()
	var/list/low_pri = list()

	for(var/mob/living/simple_animal/check_mob in GLOB.alive_mob_list)
		set_mob_priority(check_mob, hi_pri, low_pri)
	for(var/mob/living/basic/check_mob in GLOB.alive_mob_list)
		set_mob_priority(check_mob, hi_pri, low_pri)

	shuffle_inplace(hi_pri)
	shuffle_inplace(low_pri)

	potential = hi_pri + low_pri

	if(!potential.len)
		return WAITING_FOR_SOMETHING
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/spawned_animals = 0
	while(spawned_animals < animals && candidates.len && potential.len)
		var/mob/living/selected = popleft(potential)
		var/mob/dead/observer/picked_candidate = pick_n_take(candidates)

		spawned_animals++

		selected.key = picked_candidate.key

		selected.grant_all_languages(UNDERSTOOD_LANGUAGE, grant_omnitongue = FALSE, source = LANGUAGE_ATOM)

		if (isanimal(selected))
			var/mob/living/simple_animal/animal_selected = selected
			animal_selected.sentience_act()
			animal_selected.del_on_death = FALSE
		else if	(isbasicmob(selected))
			var/mob/living/basic/animal_selected = selected
			animal_selected.basic_mob_flags &= ~DEL_ON_DEATH

		selected.maxHealth = max(selected.maxHealth, 200)
		selected.health = selected.maxHealth
		spawned_mobs += selected

		to_chat(selected, span_userdanger("Привет, мир!"))
		to_chat(selected, "<span class='warning'>Благодаря радиации и/или химикатам \
			и/или счастливой случайности, вы обрели интеллект человеческого уровня \
			и способность говорить и понимать человеческий язык!</span>")

	return SUCCESSFUL_SPAWN

/// Adds a mob to either the high or low priority event list
/datum/round_event/ghost_role/sentience/proc/set_mob_priority(mob/living/checked_mob, list/high, list/low)
	var/turf/mob_turf = get_turf(checked_mob)
	if(!mob_turf || !is_station_level(mob_turf.z))
		return
	if((checked_mob in GLOB.player_list) || checked_mob.mind || (checked_mob.flags_1 & HOLOGRAM_1))
		return
	if(is_type_in_typecache(checked_mob, GLOB.high_priority_sentience))
		high += checked_mob
	else
		low += checked_mob

/datum/round_event_control/sentience/all
	name = "Station-wide Human-level Intelligence"
	typepath = /datum/round_event/ghost_role/sentience/all
	weight = 0
	category = EVENT_CATEGORY_FRIENDLY
	description = "ALL animals and robots become sentient, provided there is enough ghosts."

/datum/round_event/ghost_role/sentience/all
	one = "все"
	animals = INFINITY // as many as there are ghosts and animals
	// cockroach pride, station wide
