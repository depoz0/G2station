/* First aid storage
 * Contains:
 * First Aid Kits
 * Pill Bottles
 * Dice Pack (in a pill bottle)
 */

/*
 * First Aid Kits
 */
/obj/item/storage/medkit
	name = "аптечка"
	desc = "Это аптечка для оказания экстренной медицинской помощи при серьезных травмах."
	icon = 'icons/obj/storage/medkit.dmi'
	icon_state = "medkit"
	inhand_icon_state = "medkit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	/// Defines damage type of the medkit. General ones stay null. Used for medibot healing bonuses
	var/damagetype_healed
	/// you just type this in holdables list of medkits instead of copypasting bunch of text.
	var/static/list/list_of_everything_medkits_can_hold = list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/lighter,
		/obj/item/storage/box/bandages,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/hypospray,
		/obj/item/sensor_device,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/lazarus_injector,
		/obj/item/bikehorn/rubberducky,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/surgical_drapes,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/bonesetter,
		/obj/item/surgicaldrill,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/blood_filter,
		/obj/item/shears,
		/obj/item/geiger_counter,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/stamp,
		/obj/item/clothing/glasses,
		/obj/item/wrench/medical,
		/obj/item/clothing/mask/muzzle,
		/obj/item/reagent_containers/blood,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/gun/syringe/syndicate,
		/obj/item/implantcase,
		/obj/item/implant,
		/obj/item/implanter,
		/obj/item/pinpointer/crew,
		/obj/item/holosign_creator/medical,
		/obj/item/stack/sticky_tape,
	)

/obj/item/storage/medkit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL

/obj/item/storage/medkit/regular
	icon_state = "medkit"
	desc = "Аптечка с возможностью лечения обычных видов травм."

/obj/item/storage/medkit/regular/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] начинает оказывать [user.p_them()]себе помощь с [src]! Это похоже на попытку  [user.p_theyre()] совершить самоубийство!"))
	return BRUTELOSS

/obj/item/storage/medkit/regular/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/emergency
	icon_state = "medbriefcase"
	name = "аптечка первой помощи"
	desc = "Очень простая аптечка, предназначенная для фиксации и стабилизации серьезных ран с целью их последующего лечения."

/obj/item/storage/medkit/emergency/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/healthanalyzer/simple = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture/emergency = 1,
		/obj/item/stack/medical/ointment = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 2,
		/obj/item/storage/pill_bottle/iron = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/surgery
	name = "хирургическая аптечка"
	icon_state = "medkit_surgery"
	inhand_icon_state = "medkit"
	desc = "Большая аптечка для врачей, укомплектованная медицинскими препаратами и основным хирургическим инструментом."

/obj/item/storage/medkit/surgery/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL //holds the same equipment as a medibelt
	atom_storage.max_slots = 12
	atom_storage.max_total_storage = 24
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

/obj/item/storage/medkit/surgery/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/ancient
	icon_state = "oldfirstaid"
	desc = "Аптечка с возможностью лечения типичных травм."

/obj/item/storage/medkit/ancient/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/bruise_pack = 3,
		/obj/item/stack/medical/ointment= 3)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/ancient/heirloom
	desc = "Аптечка с возможностью лечения типичных травм. При одном только взгляде на нее начинаешь вспоминать старые добрые времена."
	empty = TRUE // long since been ransacked by hungry powergaming assistants breaking into med storage

/obj/item/storage/medkit/fire
	name = "аптечка для обработки ожогов"
	desc = "Специализированная аптечка на случай <i>самопроизвольного</i> возгорания лаборатории боеприпасов."
	icon_state = "medkit_burn"
	inhand_icon_state = "medkit-ointment"
	damagetype_healed = BURN

/obj/item/storage/medkit/fire/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins rubbing \the [src] against [user.p_them()]self! Это похоже на попытку [user.p_theyre()] разжечь огонь!"))
	return FIRELOSS

/obj/item/storage/medkit/fire/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/pill/patch/aiuri = 3,
		/obj/item/reagent_containers/spray/hercuri = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/toxin
	name = "аптечка для лечения отравлений"
	desc = "Применяется для лечения ядов в крови и радиационных отравлений."
	icon_state = "medkit_toxin"
	inhand_icon_state = "medkit-toxin"
	damagetype_healed = TOX

/obj/item/storage/medkit/toxin/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins licking the lead paint off \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return TOXLOSS


/obj/item/storage/medkit/toxin/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/storage/pill_bottle/multiver/less = 1,
		/obj/item/reagent_containers/syringe/syriniver = 3,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 1,
		/obj/item/healthanalyzer/simple/disease = 1,
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/o2
	name = "аптечка для лечения кислородного голодания"
	desc = "Ящик, наполненный различными товарами для поддержки кислорода в теле."
	icon_state = "medkit_o2"
	inhand_icon_state = "medkit-o2"
	damagetype_healed = OXY

/obj/item/storage/medkit/o2/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins hitting [user.p_their()] neck with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return OXYLOSS

/obj/item/storage/medkit/o2/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/syringe/convermol = 3,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/storage/pill_bottle/iron = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/brute
	name = "аптечка для лечения тяжелых травм"
	desc = "A first aid kit for when you get toolboxed."
	icon_state = "medkit_brute"
	inhand_icon_state = "medkit-brute"
	damagetype_healed = BRUTE

/obj/item/storage/medkit/brute/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins beating [user.p_them()]self over the head with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/storage/medkit/brute/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/pill/patch/libital = 3,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/storage/pill_bottle/probital = 1,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 1,
		/obj/item/healthanalyzer/simple = 1,
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/advanced
	name = "передовая аптечка первой помощи"
	desc = "Передовая аптечка, помогающая справиться с тяжелыми ранами."
	icon_state = "medkit_advanced"
	inhand_icon_state = "medkit-rad"
	custom_premium_price = PAYCHECK_COMMAND * 6
	damagetype_healed = HEAL_ALL_DAMAGE

/obj/item/storage/medkit/advanced/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/pill/patch/synthflesh = 3,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 2,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/storage/pill_bottle/penacid = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical
	name = "боевая медицинская аптечка"
	desc = "Надеюсь, у вас есть страховка."
	icon_state = "medkit_tactical"
	inhand_icon_state = "medkit-tactical"
	damagetype_healed = HEAL_ALL_DAMAGE

/obj/item/storage/medkit/tactical/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 21
	atom_storage.max_total_storage = 24
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

/obj/item/storage/medkit/tactical/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/cautery = 1,
		/obj/item/scalpel = 1,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/hemostat = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/storage/box/bandages = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 2,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/reagent_containers/pill/patch/libital = 4,
		/obj/item/reagent_containers/pill/patch/aiuri = 4,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium
	name = "боевая медицинская аптечка премиум класса"
	desc = "Может содержать или не содержать частицы свинца."
	grind_results = list(/datum/reagent/lead = 10)

/obj/item/storage/medkit/tactical/premium/Initialize(mapload)
	. = ..()
	atom_storage.allow_big_nesting = TRUE // so you can put back the box you took out
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 21
	atom_storage.max_total_storage = 34
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

/obj/item/storage/medkit/tactical/premium/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/reagent_containers/pill/patch/libital = 3,
		/obj/item/reagent_containers/pill/patch/aiuri = 3,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/mod/module/thread_ripper = 1,
		/obj/item/mod/module/surgical_processor/preloaded = 1,
		/obj/item/mod/module/defibrillator/combat = 1,
		/obj/item/mod/module/health_analyzer = 1,
		/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset = 1,
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/storage/box/bandages = 1,
		/obj/item/storage/box/evilmeds = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/clothing/glasses/hud/health/night/science = 1,
	)
	generate_items_inside(items_inside,src)
	list_of_everything_medkits_can_hold += items_inside

/obj/item/storage/medkit/coroner
	name = "компактная аптечка судмедэксперта"
	desc = "Небольшая медицинская аптечка, предназначенная в первую очередь для оказания помощи при препарировании умерших, а не для лечения живых."
	icon = 'icons/obj/storage/medkit.dmi'
	icon_state = "compact_coronerkit"
	inhand_icon_state = "coronerkit"

/obj/item/storage/medkit/coroner/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 14
	atom_storage.max_total_storage = 24
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers,
		/obj/item/bodybag,
		/obj/item/toy/crayon,
		/obj/item/pen,
		/obj/item/paper,
		/obj/item/surgical_drapes,
		/obj/item/scalpel,
		/obj/item/retractor,
		/obj/item/hemostat,
		/obj/item/cautery,
		/obj/item/autopsy_scanner,
	))

/obj/item/storage/medkit/coroner/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/reagent_containers/blood = 1,
		/obj/item/bodybag = 2,
		/obj/item/reagent_containers/syringe = 1,
	)
	generate_items_inside(items_inside,src)

//medibot assembly
/obj/item/storage/medkit/attackby(obj/item/bodypart/bodypart, mob/user, params)
	if((!istype(bodypart, /obj/item/bodypart/arm/left/robot)) && (!istype(bodypart, /obj/item/bodypart/arm/right/robot)))
		return ..()

	//Making a medibot!
	if(contents.len >= 1)
		balloon_alert(user, "предметы внутри!")
		return

	///if you add a new one don't forget to update /datum/crafting_recipe/medbot/on_craft_completion()
	var/obj/item/bot_assembly/medbot/medbot_assembly = new
	if (istype(src, /obj/item/storage/medkit/fire))
		medbot_assembly.set_skin("ointment")
	else if (istype(src, /obj/item/storage/medkit/toxin))
		medbot_assembly.set_skin("tox")
	else if (istype(src, /obj/item/storage/medkit/o2))
		medbot_assembly.set_skin("o2")
	else if (istype(src, /obj/item/storage/medkit/brute))
		medbot_assembly.set_skin("brute")
	else if (istype(src, /obj/item/storage/medkit/advanced))
		medbot_assembly.set_skin("advanced")
	else if (istype(src, /obj/item/storage/medkit/tactical))
		medbot_assembly.set_skin("bezerk")
	user.put_in_hands(medbot_assembly)
	medbot_assembly.balloon_alert(user, "arm added")
	medbot_assembly.robot_arm = bodypart.type
	medbot_assembly.medkit_type = type
	qdel(bodypart)
	qdel(src)

/*
 * Pill Bottles
 */

/obj/item/storage/pill_bottle
	name = "контейнер с таблетками"
	desc = "Это герметичный контейнер для хранения лекарств."
	icon_state = "pill_canister"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/pill_bottle/Initialize(mapload)
	. = ..()
	atom_storage.allow_quick_gather = TRUE
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers/pill,
		/obj/item/food/bait/natural,
	))

/obj/item/storage/pill_bottle/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] пытается снять крышку с [src]! Это похоже на попытку [user.p_theyre()] совершить самоубийство!"))
	return TOXLOSS

/obj/item/storage/pill_bottle/multiver
	name = "упаковка таблеток Мультивер"
	desc = "Содержит таблетки, используемые для противодействия отравлениям."

/obj/item/storage/pill_bottle/multiver/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/multiver(src)

/obj/item/storage/pill_bottle/multiver/less

/obj/item/storage/pill_bottle/multiver/less/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/multiver(src)

/obj/item/storage/pill_bottle/epinephrine
	name = "упаковка таблеток эпинефрина"
	desc = "Содержит таблетки, используемые для стабилизации состояния пациентов."

/obj/item/storage/pill_bottle/epinephrine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/epinephrine(src)

/obj/item/storage/pill_bottle/mutadone
	name = "упаковка таблеток мутадона"
	desc = "Содержит таблетки, используемые для лечения генетических аномалий."

/obj/item/storage/pill_bottle/mutadone/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mutadone(src)

/obj/item/storage/pill_bottle/potassiodide
	name = "упаковка таблеток йодистого калия"
	desc = "Содержит таблетки, используемые для снижения радиационного поражения."

/obj/item/storage/pill_bottle/potassiodide/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/potassiodide(src)

/obj/item/storage/pill_bottle/probital
	name = "упаковка таблеток пробитал"
	desc = "Содержит таблетки, используемые для лечения тяжелых травм. На бутылке имеется надпись: 'Употребление после еды, может вызвать усталость'."

/obj/item/storage/pill_bottle/probital/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/probital(src)

/obj/item/storage/pill_bottle/iron
	name = "упаковка таблеток железа"
	desc = "Содержит таблетки, используемые для медленного уменьшения кровопотери. На этикетке флакона указано: 'Принимать только по одной каждые пять минут'."

/obj/item/storage/pill_bottle/iron/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/iron(src)

/obj/item/storage/pill_bottle/mannitol
	name = "упаковка таблеток маннитола"
	desc = "Содержит таблетки, используемые для лечения повреждений головного мозга."

/obj/item/storage/pill_bottle/mannitol/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mannitol(src)

//Contains 4 pills instead of 7, and 5u pills instead of 50u (50u pills heal 250 brain damage, 5u pills heal 25)
/obj/item/storage/pill_bottle/mannitol/braintumor
	desc = "Содержит разбавленные таблетки, используемые для лечения симптомов опухоли головного мозга. Примите одну таблетку при головокружении."

/obj/item/storage/pill_bottle/mannitol/braintumor/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/mannitol/braintumor(src)

/obj/item/storage/pill_bottle/stimulant
	name = "упаковка стимулирующих таблеток"
	desc = "Гарантированно обеспечит дополнительный прилив энергии во время длительного прибывания на станции!"

/obj/item/storage/pill_bottle/stimulant/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/stimulant(src)

/obj/item/storage/pill_bottle/sansufentanyl
	name = "упаковка с экспериментальным препаратом"
	desc = "Упаковка таблеток, разработанных компанией Interdyne Pharmaceuticals. Они используются для лечения наследственной болезни."

/obj/item/storage/pill_bottle/sansufentanyl/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/pill/sansufentanyl(src)

/obj/item/storage/pill_bottle/mining
	name = "упаковка с пластырями"
	desc = "Содержит пластыри, используемые для лечения тяжелых и ожоговых ран."

/obj/item/storage/pill_bottle/mining/PopulateContents()
	new /obj/item/reagent_containers/pill/patch/aiuri(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/patch/libital(src)

/obj/item/storage/pill_bottle/zoom
	name = "подозрительная упаковка с таблетками"
	desc = "Этикетка довольно старая и почти не читаемая, на ней можно разглядеть некоторые химические соединения."

/obj/item/storage/pill_bottle/zoom/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/zoom(src)

/obj/item/storage/pill_bottle/happy
	name = "подозрительная упаковка с таблетками"
	desc = "На верхней стороне упаковки нарисован смайлик."

/obj/item/storage/pill_bottle/happy/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/happy(src)

/obj/item/storage/pill_bottle/lsd
	name = "подозрительная упаковка с таблетками"
	desc = "Имеется неразборчивый рисунок, который может быть либо грибом, либо покореженной луной."

/obj/item/storage/pill_bottle/lsd/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/lsd(src)

/obj/item/storage/pill_bottle/aranesp
	name = "подозрительная упаковка с таблетками"
	desc = "На этикетке черным маркером торопливо написано 'fuck disablers'."

/obj/item/storage/pill_bottle/aranesp/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/aranesp(src)

/obj/item/storage/pill_bottle/psicodine
	name = "упаковка таблеток псикодина"
	desc = "Содержит таблетки, используемые для лечения психических расстройств и травм."

/obj/item/storage/pill_bottle/psicodine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/psicodine(src)

/obj/item/storage/pill_bottle/penacid
	name = "упаковка таблеток пентеиновой кислоты"
	desc = "Содержит таблетки для выведения из организма радиации и ядов."

/obj/item/storage/pill_bottle/penacid/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/penacid(src)


/obj/item/storage/pill_bottle/neurine
	name = "упаковка таблеток неврин"
	desc = "Содержит таблетки для лечения нетяжелых психических травм."

/obj/item/storage/pill_bottle/neurine/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/neurine(src)

/obj/item/storage/pill_bottle/maintenance_pill
	name = "упаковка профилактических таблеток"
	desc = "Старая упаковка таблеток. Пахнет дурно."

/obj/item/storage/pill_bottle/maintenance_pill/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/pill/P = locate() in src
	name = "упаковка выписана на имя [P.name]"

/obj/item/storage/pill_bottle/maintenance_pill/PopulateContents()
	for(var/i in 1 to rand(1,7))
		new /obj/item/reagent_containers/pill/maintenance(src)

/obj/item/storage/pill_bottle/maintenance_pill/full/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/maintenance(src)

///////////////////////////////////////// Psychologist inventory pillbottles
/obj/item/storage/pill_bottle/happinesspsych
	name = "таблетки счастья"
	desc = "Эти таблетки используются в качестве последнего средства для временной борьбы с депрессией и тревогой. ВНИМАНИЕ: побочные эффекты могут включать невнятную речь, выделение слюны и сильную зависимость."

/obj/item/storage/pill_bottle/happinesspsych/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/happinesspsych(src)

/obj/item/storage/pill_bottle/lsdpsych
	name = "таблетки разрушающие разум"
	desc = "ТОЛЬКО ДЛЯ ТЕРАПЕВТИЧЕСКОГО ИСПОЛЬЗОВАНИЯ! Таблетки, используемые для облегчения симптомов синдрома диссоциации реальности."

/obj/item/storage/pill_bottle/lsdpsych/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/lsdpsych(src)

/obj/item/storage/pill_bottle/paxpsych
	name = "таблетки пакс"
	desc = "Содержит таблетки, используемые для временного успокоения пациентов, представляющих опасность для себя и окружающих."

/obj/item/storage/pill_bottle/paxpsych/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/paxpsych(src)

/obj/item/storage/pill_bottle/naturalbait
	name = "freshness jar"
	desc = "Full of natural fish bait."

/obj/item/storage/pill_bottle/naturalbait/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/bait/natural(src)

/obj/item/storage/pill_bottle/ondansetron
	name = "пластыри с ондансетроном"
	desc = "Упаковка, содержащая пластыри с ондансетроном - препаратом, применяемым для лечения тошноты и рвоты. Может вызывать сонливость."

/obj/item/storage/pill_bottle/ondansetron/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/ondansetron(src)

/// A box which takes in coolant and uses it to preserve organs and body parts
/obj/item/storage/organbox
	name = "контейнер для транспортировки органов"
	desc = "Усовершенствованный контейнер с охлаждающим механизмом, в котором используется криостилан или другие холодные реагенты для сохранения находящихся в нем органов или частей тела."
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "organbox"
	base_icon_state = "organbox"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	custom_premium_price = PAYCHECK_CREW * 4
	/// var to prevent it freezing the same things over and over
	var/cooling = FALSE

/obj/item/storage/organbox/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/organ_box, max_specific_storage = WEIGHT_CLASS_BULKY, max_total_storage = 21)
	atom_storage.set_holdable(list(
		/obj/item/organ,
		/obj/item/bodypart,
		/obj/item/food/icecream
		))

	create_reagents(100, TRANSPARENT)
	START_PROCESSING(SSobj, src)

/obj/item/storage/organbox/process(seconds_per_tick)
	///if there is enough coolant var
	var/using_coolant = coolant_to_spend()
	if (isnull(using_coolant))
		if (cooling)
			cooling = FALSE
			update_appearance()
			for(var/obj/stored in contents)
				stored.unfreeze()
		return

	var/amount_used = 0.05 * seconds_per_tick
	if (using_coolant != /datum/reagent/cryostylane)
		amount_used *= 2
	reagents.remove_reagent(using_coolant, amount_used)

	if(cooling)
		return
	cooling = TRUE
	update_appearance()
	for(var/obj/stored in contents)
		stored.freeze()

/// Returns which coolant we are about to use, or null if there isn't any
/obj/item/storage/organbox/proc/coolant_to_spend()
	if (reagents.get_reagent_amount(/datum/reagent/cryostylane))
		return /datum/reagent/cryostylane
	if (reagents.get_reagent_amount(/datum/reagent/consumable/ice))
		return /datum/reagent/consumable/ice
	return null

/obj/item/storage/organbox/update_icon_state()
	icon_state = "[base_icon_state][cooling ? "-working" : null]"
	return ..()

/obj/item/storage/organbox/attackby(obj/item/I, mob/user, params)
	if(is_reagent_container(I) && I.is_open_container())
		var/obj/item/reagent_containers/RC = I
		var/units = RC.reagents.trans_to(src, RC.amount_per_transfer_from_this, transferred_by = user)
		if(units)
			balloon_alert(user, "[units]u transferred")
			return
	if(istype(I, /obj/item/plunger))
		balloon_alert(user, "plunging...")
		if(do_after(user, 10, target = src))
			balloon_alert(user, "plunged")
			reagents.clear_reagents()
		return
	return ..()

/obj/item/storage/organbox/suicide_act(mob/living/carbon/user)
	if(HAS_TRAIT(user, TRAIT_RESISTCOLD)) //if they're immune to cold, just do the box suicide
		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
		if(myhead)
			user.visible_message(span_suicide("[user] puts [user.p_their()] head into \the [src] and begins closing it! It looks like [user.p_theyre()] trying to commit suicide!"))
			myhead.dismember()
			myhead.forceMove(src) //force your enemies to kill themselves with your head collection box!
			playsound(user, "desecration-01.ogg", 50, TRUE, -1)
			return BRUTELOSS
		user.visible_message(span_suicide("[user] is beating [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
		return BRUTELOSS
	user.visible_message(span_suicide("[user] is putting [user.p_their()] head inside the [src], it looks like [user.p_theyre()] trying to commit suicide!"))
	user.adjust_bodytemperature(-300)
	user.apply_status_effect(/datum/status_effect/freon)
	return FIRELOSS

/// A subtype of organ storage box which starts with a full coolant tank
/obj/item/storage/organbox/preloaded

/obj/item/storage/organbox/preloaded/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/cryostylane, reagents.maximum_volume)

/obj/item/storage/test_tube_rack
	name = "стеллаж для пробирок"
	desc = "Деревянный стеллаж для хранения пробирок."
	icon_state = "rack"
	base_icon_state = "rack"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/test_tube_rack/Initialize(mapload)
	. = ..()
	atom_storage.allow_quick_gather = TRUE
	atom_storage.max_slots = 8
	atom_storage.screen_max_columns = 4
	atom_storage.screen_max_rows = 2
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers/cup/tube,
	))

/obj/item/storage/test_tube_rack/attack_self(mob/user)
	emptyStorage()

/obj/item/storage/test_tube_rack/update_icon_state()
	icon_state = "[base_icon_state][contents.len > 0 ? contents.len : null]"
	return ..()
