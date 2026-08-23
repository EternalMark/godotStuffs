extends TileMapLayer

# Precargamos la escena de la abeja
@onready var bee_scene = preload("res://Aprendiendo/escenas/jugador.tscn")

# Arrastra o referencia aquí el nodo contenedor 'abejas' desde el Inspector
#@export var abejas_container: Node2D
@onready var abejas_container =$"../../Jugador"

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# 1. Obtener la posición del ratón en el mundo
		var global_mouse_pos = get_global_mouse_position()
		
		# 2. Convertir la posición en píxeles a la coordenada vectorial de la celda (x, y)
		var tile_pos = local_to_map(to_local(global_mouse_pos))
		print(tile_pos," ")
		# 3. Verificar si el clic fue en un tile válido del mapa
		#if get_cell_source_id(tile_pos) != -1:
		colocar_abeja(tile_pos)
		get_viewport().set_input_as_handled()

func colocar_abeja(tile_pos: Vector2i) -> void:
	# Instanciar el nodo de la abeja
	var bee_instance = bee_scene.instantiate()
	
	# Convertir la coordenada de la cuadrícula a la posición local en píxeles (al centro del tile)
	var local_pos = map_to_local(tile_pos)
	
	# Asignar la posición calculada a la abeja
	bee_instance.position = local_pos
	
	# Agregar la abeja al contenedor deseado
	if abejas_container:
		abejas_container.add_child(bee_instance)
	else:
		# Si no asignaste el nodo contenedor, se agrega a la capa directamente
		add_child(bee_instance)
