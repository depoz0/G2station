/turf/closed/wall/material
	name = "стена"
	desc = "Огромный кусок металла, используемый для разделения помещений."
	icon = 'icons/turf/walls/materialwall.dmi'
	icon_state = "materialwall-0"
	base_icon_state = "materialwall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_MATERIAL_WALLS
	canSmoothWith = SMOOTH_GROUP_MATERIAL_WALLS
	rcd_memory = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/turf/closed/wall/material/break_wall()
	for(var/i in custom_materials)
		var/datum/material/M = i
		new M.sheet_type(src, FLOOR(custom_materials[M] / SHEET_MATERIAL_AMOUNT, 1))
	return new girder_type(src)

/turf/closed/wall/material/devastate_wall()
	for(var/i in custom_materials)
		var/datum/material/M = i
		new M.sheet_type(src, FLOOR(custom_materials[M] / SHEET_MATERIAL_AMOUNT, 1))

/turf/closed/wall/material/mat_update_desc(mat)
	desc = "A huge chunk of [mat] used to separate rooms."

