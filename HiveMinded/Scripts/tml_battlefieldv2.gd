extends TileMapLayer

#@onready var bee_scene =preload("res://Escenas/Abeja.tscn")
@export var abejas_container: Node2D
@onready var bee_scene =preload("res://Escenas/Abeja.tscn")
#@onready var bee_container = $"../../Bees"


# Diccionario para rastrear la abeja en cada casilla: Vector2i -> Node2D
var celdas_ocupadas: Dictionary = {}

# Guarda las coordenadas del tile seleccionado con clic derecho
var tile_seleccionado = null

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not event.pressed:
		return
		
	# --- LIMPIEZA PREVIA DE NODOS ELIMINADOS ---
	# Recorremos el diccionario para borrar referencias a abejas que sufrieron queue_free()
	for tile in celdas_ocupadas.keys():
		if not is_instance_valid(celdas_ocupadas[tile]):
			celdas_ocupadas.erase(tile)
	
	# Si la abeja seleccionada fue destruida mientras estaba seleccionada, limpiamos el estado
	if tile_seleccionado != null and not celdas_ocupadas.has(tile_seleccionado):
		tile_seleccionado = null
		
	var global_mouse_pos = get_global_mouse_position()
	var tile_pos = local_to_map(to_local(global_mouse_pos))

	# --- CLIC IZQUIERDO: SPAWNEAR ABEJA ---
	if event.button_index == MOUSE_BUTTON_LEFT:
		if not celdas_ocupadas.has(tile_pos):
			colocar_abeja(tile_pos)
			get_viewport().set_input_as_handled()

	# --- CLIC DERECHO: SELECCIONAR Y MOVER / INTERCAMBIAR ---
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		# PASO 1: Si no hay selección previa, intentar seleccionar una abeja
		if tile_seleccionado == null:
			if celdas_ocupadas.has(tile_pos):
				tile_seleccionado = tile_pos
				print("Abeja seleccionada en: ", tile_seleccionado)
		
		# PASO 2: Si ya hay una selección previa
		else:
			# Si hace clic derecho en la misma casilla, deselecciona
			if tile_pos == tile_seleccionado:
				tile_seleccionado = null
				print("Selección cancelada")
			
			# Comprobar si el tile destino es adyacente
			elif es_adyacente(tile_seleccionado, tile_pos):
				mover_o_intercambiar_abejas(tile_seleccionado, tile_pos)
				tile_seleccionado = null # Limpiar selección tras el movimiento
			else:
				print("El tile destino no es adyacente")
				tile_seleccionado = null
		
		get_viewport().set_input_as_handled()

# Función para verificar si dos celdas son adyacentes (arriba, abajo, izq, der o diagonales)
func es_adyacente(origen: Vector2i, destino: Vector2i) -> bool:
	var diff = (destino - origen).abs()
	return diff.x <= 1 and diff.y <= 1 and diff != Vector2i.ZERO

func colocar_abeja(tile_pos: Vector2i) -> void:
	var bee_instance = bee_scene.instantiate()
	bee_instance.position = map_to_local(tile_pos)
	
	if abejas_container:
		abejas_container.add_child(bee_instance)
	else:
		add_child(bee_instance)
	
	# Guardar la referencia del nodo instanciado en el diccionario
	celdas_ocupadas[tile_pos] = bee_instance

func mover_o_intercambiar_abejas(origen: Vector2i, destino: Vector2i) -> void:
	var abeja_origen: Node2D = celdas_ocupadas[origen]
	
	# CASO 1: El tile destino ya tiene otra abeja -> INTERCAMBIAR
	if celdas_ocupadas.has(destino):
		var abeja_destino: Node2D = celdas_ocupadas[destino]
		
		# Intercambiar posiciones en el mundo
		abeja_origen.position = map_to_local(destino)
		abeja_destino.position = map_to_local(origen)
		
		# Actualizar referencias del diccionario
		celdas_ocupadas[origen] = abeja_destino
		celdas_ocupadas[destino] = abeja_origen
		print("Abejas intercambiadas entre ", origen, " y ", destino)
	
	# CASO 2: El tile destino está vacío -> MOVER
	else:
		abeja_origen.position = map_to_local(destino)
		
		# Actualizar registros del diccionario
		celdas_ocupadas.erase(origen)
		celdas_ocupadas[destino] = abeja_origen
		print("Abeja movida a: ", destino)
