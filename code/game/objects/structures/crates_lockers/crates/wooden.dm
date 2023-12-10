/obj/structure/closet/crate/wooden
	name = "деревянный ящик"
	desc = "Работает так же хорошо как и металлический."
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 6
	icon_state = "wooden"
	base_icon_state = "wooden"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	paint_jobs = null

/obj/structure/closet/crate/wooden/toy
	name = "ящик для игрушек"
	desc = "Под ним маркером написаны слова \"Клоун + мим\"."

/obj/structure/closet/crate/wooden/toy/PopulateContents()
	. = ..()
	new /obj/item/megaphone/clown(src)
	new /obj/item/reagent_containers/cup/soda_cans/canned_laughter(src)
	new /obj/item/pneumatic_cannon/pie(src)
	new /obj/item/food/pie/cream(src)
	new /obj/item/storage/crayons(src)
