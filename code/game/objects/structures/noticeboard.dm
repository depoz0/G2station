#define MAX_NOTICES 8

/obj/structure/noticeboard
	name = "доска объявлений"
	desc = "Доска для прикрепления важных объявлений. Она изготовлена из лучшей испанской пробки."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "noticeboard"
	density = FALSE
	anchored = TRUE
	max_integrity = 150
	/// Current number of a pinned notices
	var/notices = 0

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/noticeboard, 32)

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()

	if(!mapload)
		return

	for(var/obj/item/I in loc)
		if(notices >= MAX_NOTICES)
			break
		if(istype(I, /obj/item/paper))
			I.forceMove(src)
			notices++
	update_appearance(UPDATE_ICON)
	find_and_hang_on_wall()

//attaching papers!!
/obj/structure/noticeboard/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/paper) || istype(O, /obj/item/photo))
		if(!allowed(user))
			to_chat(user, span_warning("Вы не имеете права добавлять объявления!"))
			return
		if(notices < MAX_NOTICES)
			if(!user.transferItemToLoc(O, src))
				return
			notices++
			update_appearance(UPDATE_ICON)
			to_chat(user, span_notice("Вы прикрепляете [O] к доске объявлений."))
		else
			to_chat(user, span_warning("Доска объявлений переполнена!"))
	else
		return ..()

/obj/structure/noticeboard/ui_state(mob/user)
	return GLOB.physical_state

/obj/structure/noticeboard/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NoticeBoard", name)
		ui.open()

/obj/structure/noticeboard/ui_data(mob/user)
	var/list/data = list()
	data["allowed"] = allowed(user)
	data["items"] = list()
	for(var/obj/item/content in contents)
		var/list/content_data = list(
			name = content.name,
			ref = REF(content)
		)
		data["items"] += list(content_data)
	return data

/obj/structure/noticeboard/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/obj/item/item = locate(params["ref"]) in contents
	if(!istype(item) || item.loc != src)
		return

	var/mob/user = usr

	switch(action)
		if("examine")
			if(istype(item, /obj/item/paper))
				item.ui_interact(user)
			else
				user.examinate(item)
			return TRUE
		if("remove")
			if(!allowed(user))
				return
			remove_item(item, user)
			return TRUE

/obj/structure/noticeboard/update_overlays()
	. = ..()
	if(notices)
		. += "notices_[notices]"

/**
 * Removes an item from the notice board
 *
 * Arguments:
 * * item - The item that is to be removed
 * * user - The mob that is trying to get the item removed, if there is one
 */
/obj/structure/noticeboard/proc/remove_item(obj/item/item, mob/user)
	item.forceMove(drop_location())
	if(user)
		user.put_in_hands(item)
		balloon_alert(user, "removed from board")
	notices--
	update_appearance(UPDATE_ICON)

/obj/structure/noticeboard/deconstruct(disassembled = TRUE)
	if(!(obj_flags & NO_DECONSTRUCTION))
		if(!disassembled)
			new /obj/item/stack/sheet/mineral/wood(loc)
		else
			new /obj/item/wallframe/noticeboard(loc)
	for(var/obj/item/content in contents)
		remove_item(content)
	qdel(src)

/obj/item/wallframe/noticeboard
	name = "notice board"
	desc = "Right now it's more of a clipboard. Attach to a wall to use."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "noticeboard"
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT,
	)
	resistance_flags = FLAMMABLE
	result_path = /obj/structure/noticeboard
	pixel_shift = 32

// Notice boards for the heads of staff (plus the qm)

/obj/structure/noticeboard/captain
	name = "Доска объявлений капитана"
	desc = "Важные объявления от капитана."
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/noticeboard/hop
	name = "Доска объявлений начальника отдела кадров"
	desc = "Важные объявления от начальника отдела кадров."
	req_access = list(ACCESS_HOP)

/obj/structure/noticeboard/ce
	name = "Доска объявлений главного инженера"
	desc = "Важные объявления от главного инженера."
	req_access = list(ACCESS_CE)

/obj/structure/noticeboard/hos
	name = "Доска объявлений начальника службы безопасности"
	desc = "Важные объявления от начальника службы безопасности."
	req_access = list(ACCESS_HOS)

/obj/structure/noticeboard/cmo
	name = "Доска объявлений главного врача"
	desc = "Важные объявления от главного врача."
	req_access = list(ACCESS_CMO)

/obj/structure/noticeboard/rd
	name = "Доска объявлений директора по исследованиям"
	desc = "Важные объявления от директора по исследованиям."
	req_access = list(ACCESS_RD)

/obj/structure/noticeboard/qm
	name = "Доска объявлений квартермейстера"
	desc = "Важные уведомления от Квартермейстера."
	req_access = list(ACCESS_QM)

/obj/structure/noticeboard/staff
	name = "Доска объявлений для руководителей"
	desc = "Важные уведомления от руководителей отделов."
	req_access = list(ACCESS_COMMAND)

#undef MAX_NOTICES
