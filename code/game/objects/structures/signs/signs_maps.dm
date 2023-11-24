//map and direction signs

/obj/structure/sign/map
	name = "карта станции"
	desc = "Навигационная схема станции."
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"

/obj/structure/sign/map/right
	icon_state = "map-right"

/obj/structure/sign/directions/science
	name = "знак научного отдела"
	desc = "Знак направления, указывающий в какой стороне находится научный отдел."
	icon_state = "direction_sci"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, 32)

/obj/structure/sign/directions/engineering
	name = "знак инженерного отдела"
	desc = "Знак направления, указывающий в какой стороне находится инженерный отдел."
	icon_state = "direction_eng"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, 32)

/obj/structure/sign/directions/security
	name = "знак отдела охраны"
	desc = "Знак направления, указывающий в какой стороне находится отдел охраны."
	icon_state = "direction_sec"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, 32)

/obj/structure/sign/directions/medical
	name = "знак медпункта"
	desc = "Знак направления, указывающий в какой стороне находится медпункт."
	icon_state = "direction_med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, 32)

/obj/structure/sign/directions/evac
	name = "знак эвакуации"
	desc = "Знак направления, указывающий в какой стороне находится док аварийного шаттла."
	icon_state = "direction_evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, 32)

/obj/structure/sign/directions/supply
	name = "знак грузовой склад"
	desc = "Знак направления, указывающий в какой стороне находится грузовой склад."
	icon_state = "direction_supply"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, 32)

/obj/structure/sign/directions/command
	name = "знак командного пункта"
	desc = "Знак направления, указывающий в какой стороне находится командный пункт."
	icon_state = "direction_bridge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, 32)

/obj/structure/sign/directions/vault
	name = "знак хранилища"
	desc = "Знак направления, указывающий в какой стороне находится хранилище станции."
	icon_state = "direction_vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, 32)

/obj/structure/sign/directions/upload
	name = "знак AI Upload"
	desc = "Знак направления, указывающий в какой стороне находится AI Upload."
	icon_state = "direction_upload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, 32)

/obj/structure/sign/directions/dorms
	name = "знак общежития"
	desc = "Знак направления, указывающий в какой стороне находятся общежитиe."
	icon_state = "direction_dorms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms, 32)

/obj/structure/sign/directions/lavaland
	name = "знак лавы"
	desc = "Знак направления, указывающий в какой стороне находится горячий товар."
	icon_state = "direction_lavaland"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland, 32)

/obj/structure/sign/directions/arrival
	name = "знак прибытия"
	desc = "Знак направления, указывающий в какой стороне находится док для прибывающих шаттлов."
	icon_state = "direction_arrival"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival, 32)
