#define ENGINE_UNWRENCHED 0
#define ENGINE_WRENCHED 1
#define ENGINE_WELDED 2
///How long it takes to weld/unweld an engine in place.
#define ENGINE_WELDTIME (20 SECONDS)

/obj/machinery/power/shuttle_engine
	name = "двигатель"
	desc = "Двигатель bluespace, используется для движения шаттлов."
	icon = 'icons/turf/shuttle.dmi'
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	smoothing_groups = SMOOTH_GROUP_SHUTTLE_PARTS
	armor_type = /datum/armor/power_shuttle_engine
	can_atmos_pass = ATMOS_PASS_DENSITY
	max_integrity = 500
	density = TRUE
	anchored = TRUE
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/engine

	///How well the engine affects the ship's speed.
	var/engine_power = 1
	///Construction state of the Engine.
	var/engine_state = ENGINE_WELDED //welding shmelding //i love welding

	///The mobile ship we are connected to.
	var/datum/weakref/connected_ship_ref

/datum/armor/power_shuttle_engine
	melee = 100
	bullet = 10
	laser = 10
	fire = 50
	acid = 70

/obj/machinery/power/shuttle_engine/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/power/shuttle_engine/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	if(!port)
		return FALSE
	connected_ship_ref = WEAKREF(port)
	port.engine_list += src
	port.current_engine_power += engine_power
	if(mapload)
		port.initial_engine_power += engine_power

/obj/machinery/power/shuttle_engine/Destroy()
	if(engine_state == ENGINE_WELDED)
		alter_engine_power(-engine_power)
	unsync_ship()
	return ..()

/obj/machinery/power/shuttle_engine/examine(mob/user)
	. = ..()
	switch(engine_state)
		if(ENGINE_UNWRENCHED)
			. += span_notice("[src] откручен от пола. Для установки его необходимо прикрутить ключом к полу.")
		if(ENGINE_WRENCHED)
			. += span_notice("[src] прикреплен к полу болтами и может быть откреплен с помощью гаечного ключа. Для завершения установки его необходимо приварить к полу.")
		if(ENGINE_WELDED)
			. += span_notice("[src] приварен к полу и может быть разварен. В настоящее время он полностью смонтирован.")

/obj/machinery/power/shuttle_engine/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(held_item?.tool_behaviour == TOOL_WELDER && engine_state == ENGINE_WRENCHED)
		context[SCREENTIP_CONTEXT_LMB] = "Приварить к полу"
	if(held_item?.tool_behaviour == TOOL_WELDER && engine_state == ENGINE_WELDED)
		context[SCREENTIP_CONTEXT_LMB] = "Отсоединить от пола"
	if(held_item?.tool_behaviour == TOOL_WRENCH && engine_state == ENGINE_UNWRENCHED)
		context[SCREENTIP_CONTEXT_LMB] = "Прикрутить к полу"
	if(held_item?.tool_behaviour == TOOL_WRENCH && engine_state == ENGINE_WRENCHED)
		context[SCREENTIP_CONTEXT_LMB] = "Открутить от пола"
	return CONTEXTUAL_SCREENTIP_SET

/**
 * Called on destroy and when we need to unsync an engine from their ship.
 */
/obj/machinery/power/shuttle_engine/proc/unsync_ship()
	var/obj/docking_port/mobile/port = connected_ship_ref?.resolve()
	if(port)
		port.engine_list -= src
		port.current_engine_power -= initial(engine_power)
	connected_ship_ref = null

//Ugh this is a lot of copypasta from emitters, welding need some boilerplate reduction
/obj/machinery/power/shuttle_engine/can_be_unfasten_wrench(mob/user, silent)
	if(engine_state == ENGINE_WELDED)
		if(!silent)
			to_chat(user, span_warning("[src] приварен к полу!"))
		return FAILED_UNFASTEN
	return ..()

/obj/machinery/power/shuttle_engine/default_unfasten_wrench(mob/user, obj/item/tool, time = 20)
	. = ..()
	if(. == SUCCESSFUL_UNFASTEN)
		if(anchored)
			connect_to_shuttle(port = SSshuttle.get_containing_shuttle(src)) //connect to a new ship, if needed
			engine_state = ENGINE_WRENCHED
		else
			unsync_ship() //not part of the ship anymore
			engine_state = ENGINE_UNWRENCHED

/obj/machinery/power/shuttle_engine/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/power/shuttle_engine/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	switch(engine_state)
		if(ENGINE_UNWRENCHED)
			to_chat(user, span_warning("[src.name] должен быть прикручен к полу!"))
		if(ENGINE_WRENCHED)
			if(!tool.tool_start_check(user, amount=round(ENGINE_WELDTIME / 5)))
				return TRUE

			user.visible_message(span_notice("[user.name] начинает приваривать [name] к полу."), \
				span_notice("Вы начинаете приваривать [src] к полу..."), \
				span_hear("Вы слышите сварку."))

			if(tool.use_tool(src, user, ENGINE_WELDTIME, volume=50))
				engine_state = ENGINE_WELDED
				to_chat(user, span_notice("Вы приварили [src] к полу."))
				alter_engine_power(engine_power)

		if(ENGINE_WELDED)
			if(!tool.tool_start_check(user, amount=round(ENGINE_WELDTIME / 5)))
				return TRUE

			user.visible_message(span_notice("[user.name] starts to cut the [name] free from the floor."), \
				span_notice("You start to cut \the [src] free from the floor..."), \
				span_hear("You hear welding."))

			if(tool.use_tool(src, user, ENGINE_WELDTIME, volume=50))
				engine_state = ENGINE_WRENCHED
				to_chat(user, span_notice("You cut \the [src] free from the floor."))
				alter_engine_power(-engine_power)
	return TRUE

//Propagates the change to the shuttle.
/obj/machinery/power/shuttle_engine/proc/alter_engine_power(mod)
	if(!mod)
		return
	var/obj/docking_port/mobile/port = connected_ship_ref?.resolve()
	if(port)
		port.alter_engines(mod)

/obj/machinery/power/shuttle_engine/heater
	name = "пусковой двигатель"
	desc = "Directs energy into compressed particles in order to power engines."
	icon_state = "heater"
	circuit = /obj/item/circuitboard/machine/engine/heater
	engine_power = 0 // todo make these into 2x1 parts

/obj/machinery/power/shuttle_engine/propulsion
	name = "силовой двигатель"
	icon_state = "propulsion"
	desc = "A standard reliable bluespace engine used by many forms of shuttles."
	circuit = /obj/item/circuitboard/machine/engine/propulsion
	opacity = TRUE

/obj/machinery/power/shuttle_engine/propulsion/left
	name = "левый силовой двигатель"
	icon_state = "propulsion_l"

/obj/machinery/power/shuttle_engine/propulsion/right
	name = "правый силовой двигатель"
	icon_state = "propulsion_r"

/obj/machinery/power/shuttle_engine/propulsion/burst
	name = "форсажный двигатель"
	desc = "An engine that releases a large bluespace burst to propel it."

/obj/machinery/power/shuttle_engine/propulsion/burst/cargo
	engine_state = ENGINE_UNWRENCHED
	anchored = FALSE

/obj/machinery/power/shuttle_engine/propulsion/burst/left
	name = "левый форсажный двигатель"
	icon_state = "burst_l"

/obj/machinery/power/shuttle_engine/propulsion/burst/right
	name = "правый форсажный двигатель"
	icon_state = "burst_r"

/obj/machinery/power/shuttle_engine/large
	name = "двигатель"
	icon = 'icons/obj/fluff/2x2.dmi'
	icon_state = "large_engine"
	desc = "Очень большой bluespace  двигатель, используемый для приведения в движение очень больших кораблей."
	circuit = null
	opacity = TRUE
	bound_width = 64
	bound_height = 64
	appearance_flags = LONG_GLIDE

/obj/machinery/power/shuttle_engine/huge
	name = "двигатель"
	icon = 'icons/obj/fluff/3x3.dmi'
	icon_state = "huge_engine"
	desc = "Очень большой bluespace двигатель, используемый для приведения в движение гигантских кораблей."
	circuit = null
	opacity = TRUE
	bound_width = 96
	bound_height = 96
	appearance_flags = LONG_GLIDE

#undef ENGINE_UNWRENCHED
#undef ENGINE_WRENCHED
#undef ENGINE_WELDED
#undef ENGINE_WELDTIME
