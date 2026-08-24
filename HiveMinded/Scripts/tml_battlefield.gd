extends TileMapLayer

@onready var bee_scene =preload("res://Escenas/Abeja.tscn")
@onready var bee_container = $"../../Bees"

# Diccionario para rastrear qué tiles ya tienen una abeja ocupante
var celdas_ocupadas: Dictionary = {}

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var global_mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(to_local(global_mouse_pos))
		
		if tile_pos.x >= 3 && tile_pos.y >= 2 && tile_pos.y <= 10:
			# 1. Comprobar si la casilla ya está ocupada
			if celdas_ocupadas.has(tile_pos):
				print("Ya hay una abeja en la posición: ", tile_pos)
				return
			
			# 2. Spawnear la abeja y registrar la casilla ocupada
			colocar_abeja(tile_pos)
			celdas_ocupadas[tile_pos] = true
			
			get_viewport().set_input_as_handled()
		
		

func colocar_abeja(tile_pos: Vector2i) -> void:
	var bee_instance = bee_scene.instantiate()
	
	# Calcular el tamaño del tile del TileMapLayer
	#var tamano_tile: Vector2 = ({(})0.5,0.5)
	
	# Colocar la abeja en la posición local del tile
	bee_instance.position = map_to_local(tile_pos)
	#bee_instance.scale = Vector2(0.5, 0.5) 
	# Agregar al contenedor
	#if abejas_container:
	bee_container.add_child(bee_instance)
	#else:
		#add_child(bee_instance)
		
