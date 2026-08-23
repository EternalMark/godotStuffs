extends TileMapLayer

# Define el ID de la fuente de tiles (usualmente 0 si solo tienes un TileSet cargado)
@export var source_id: int = 0

# Coordenadas (atlas_coords) del nuevo tile que quieres colocar al hacer clic
@export var target_atlas_coords: Vector2i = Vector2i(1, 0)

func _unhandled_input(event: InputEvent) -> void:
	# Detecta el clic izquierdo del ratón
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Diste Clic")
		# Obtiene la posición global del ratón
		var global_mouse_pos = get_global_mouse_position()
		
		# Convierte la posición global a coordenadas de celda (grid) del TileMapLayer
		var tile_pos = local_to_map(to_local(global_mouse_pos))
		print(tile_pos," ")
		# Verifica si la casilla actual existe dentro del TileMapLayer
		#if get_cell_source_id(tile_pos) != -1:
			# Cambia el tile por el nuevo atlas coord
		set_cell(tile_pos, source_id, target_atlas_coords)
		print("Cambia tile")
		#else: 
			#print("No cambia tile")
