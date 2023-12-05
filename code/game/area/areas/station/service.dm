/area/station/service
	airlock_wires = /datum/wires/airlock/service

/*
* Bar/Kitchen Areas
*/

/area/station/service/cafeteria
	name = "Кафетерия"
	icon_state = "cafeteria"

/area/station/service/kitchen
	name = "Кухня"
	icon_state = "kitchen"

/area/station/service/kitchen/coldroom
	name = "Холодильная камера кухни"
	icon_state = "kitchen_cold"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/station/service/kitchen/diner
	name = "Закусочная"
	icon_state = "diner"

/area/station/service/kitchen/kitchen_backroom
	name = "Кухня Подсобка"
	icon_state = "kitchen_backroom"

/area/station/service/bar
	name = "Бар"
	icon_state = "bar"
	mood_bonus = 5
	mood_message = "Я обожаю бывать в баре!"
	mood_trait = TRAIT_EXTROVERT
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_WOODFLOOR

/area/station/service/bar/Initialize(mapload)
	. = ..()
	GLOB.bar_areas += src

/area/station/service/bar/atrium
	name = "\improper Atrium"
	icon_state = "bar"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/station/service/bar/backroom
	name = "Подсобка бара"
	icon_state = "bar_backroom"

/*
* Entertainment/Library Areas
*/

/area/station/service/theater
	name = "Театр"
	icon_state = "theatre"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/station/service/greenroom
	name = "Зеленая комната"
	icon_state = "theatre"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/station/service/library
	name = "Библиотека"
	icon_state = "library"
	mood_bonus = 5
	mood_message = "Я обожаю бывать в библиотеке!"
	mood_trait = TRAIT_INTROVERT
	area_flags = CULT_PERMITTED | BLOBS_ALLOWED | UNIQUE_AREA
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/station/service/library/garden
	name = "Библиотечный сад"
	icon_state = "library_garden"

/area/station/service/library/lounge
	name = "Библиотечный зал"
	icon_state = "library_lounge"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/station/service/library/artgallery
	name = "Галерея искусств"
	icon_state = "library_gallery"

/area/station/service/library/private
	name = "\improper Library Private Study"
	icon_state = "library_gallery_private"

/area/station/service/library/upper
	name = "\improper Library Upper Floor"
	icon_state = "library"

/area/station/service/library/printer
	name = "\improper Library Printer Room"
	icon_state = "library"

/*
* Chapel/Pubby Monestary Areas
*/

/area/station/service/chapel
	name = "Церковь "
	icon_state = "chapel"
	mood_bonus = 5
	mood_message = "Пребывание в церкви приносит мне покой."
	mood_trait = TRAIT_SPIRITUAL
	ambience_index = AMBIENCE_HOLY
	flags_1 = NONE
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/station/service/chapel/monastery
	name = "Монастырь"

/area/station/service/chapel/office
	name = "Офис церкви"
	icon_state = "chapeloffice"

/area/station/service/chapel/asteroid
	name = "\improper Chapel Asteroid"
	icon_state = "explored"
	sound_environment = SOUND_AREA_ASTEROID

/area/station/service/chapel/asteroid/monastery
	name = "\improper Monastery Asteroid"

/area/station/service/chapel/dock
	name = "\improper Chapel Dock"
	icon_state = "construction"

/area/station/service/chapel/storage
	name = "\improper Chapel Storage"
	icon_state = "chapelstorage"

/area/station/service/chapel/funeral
	name = "\improper Chapel Funeral Room"
	icon_state = "chapelfuneral"

/area/station/service/hydroponics/garden/monastery
	name = "\improper Monastery Garden"
	icon_state = "hydro"

/*
* Hydroponics/Garden Areas
*/

/area/station/service/hydroponics
	name = "Гидропоника"
	icon_state = "hydro"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/station/service/hydroponics/upper
	name = "Upper Hydroponics"
	icon_state = "hydro"

/area/station/service/hydroponics/garden
	name = "Сад"
	icon_state = "garden"

/*
* Misc/Unsorted Rooms
*/

/area/station/service/lawoffice
	name = "Адвокатский кабинет"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/station/service/janitor
	name = "\improper Custodial Closet"
	icon_state = "janitor"
	area_flags = CULT_PERMITTED | BLOBS_ALLOWED | UNIQUE_AREA
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/station/service/barber
	name = "Парикмахерская"
	icon_state = "barber"

/*
* Abandoned Rooms
*/

/area/station/service/hydroponics/garden/abandoned
	name = "Заброшенный сад"
	icon_state = "abandoned_garden"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/station/service/kitchen/abandoned
	name = "Заброшенная кухня"
	icon_state = "abandoned_kitchen"

/area/station/service/electronic_marketing_den
	name = "\improper Electronic Marketing Den"
	icon_state = "abandoned_marketing_den"

/area/station/service/abandoned_gambling_den
	name = "\improper Abandoned Gambling Den"
	icon_state = "abandoned_gambling_den"

/area/station/service/abandoned_gambling_den/gaming
	name = "\improper Abandoned Gaming Den"
	icon_state = "abandoned_gaming_den"

/area/station/service/theater/abandoned
	name = "\improper Abandoned Theater"
	icon_state = "abandoned_theatre"

/area/station/service/library/abandoned
	name = "\improper Abandoned Library"
	icon_state = "abandoned_library"
