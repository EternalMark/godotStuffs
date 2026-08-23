extends TileMapLayer

@onready var bee_scene = preload("res://Aprendiendo/escenas/jugador.tscn")
#@export var abejas_container: Node2D
@onready var abejas_container =$"../../Jugador"

# Diccionario para rastrear qué tiles ya tienen una abeja ocupante
var celdas_ocupadas: Dictionary = {}

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var global_mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(to_local(global_mouse_pos))
		
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
	bee_instance.scale = Vector2(0.5, 0.5) 
	# Agregar al contenedor
	#if abejas_container:
	abejas_container.add_child(bee_instance)
	#else:
		#add_child(bee_instance)
		
	
	
	# Escalar la abeja para que quepa exactamente en el tamaño del tile
	#escalar_abeja_a_tile(bee_instance, tamano_tile)

func escalar_abeja_a_tile(instancia: Node2D, tamano_destino: Vector2) -> void:
	# Buscar el Sprite2D/AnimatedSprite2D dentro de la escena de la abeja
	var sprite = instancia.get_node_or_null("Sprite2D") # Cambia por el nombre de tu nodo Sprite
	
	if sprite and sprite.texture:
		var tamano_textura = sprite.texture.get_size()
		# Calcula el factor de escala necesario (ejemplo: 64px destino / 128px origen = 0.5)
		var factor_escala = tamano_destino / tamano_textura
		instancia.scale = factor_escala
