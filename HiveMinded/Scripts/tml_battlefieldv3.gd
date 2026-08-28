extends TileMapLayer

@export var abejas_container: Node2D
@onready var bee_scene =preload("res://Escenas/Abeja.tscn")

# Diccionario para rastrear la abeja en cada casilla: Vector2i -> Node2D
var celdas_ocupadas: Dictionary = {}

# Variables para el estado de arrastre
var abeja_arrastrada: Node2D = null
var tile_origen = null
var es_nueva_abeja: bool = false

func _process(_delta: float) -> void:
	# Mientras estemos arrastrando una abeja, su posición sigue al ratón
	if is_instance_valid(abeja_arrastrada):
		# Mantenemos a la abeja arrastrada por encima de los demás nodos
		abeja_arrastrada.z_index = 100
		
		# Si la abeja o sus hijos están en un contenedor externo, convertimos el ratón a global
		abeja_arrastrada.global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var global_mouse_pos = get_global_mouse_position()
			var tile_pos = local_to_map(to_local(global_mouse_pos))

			# --- PRESIONAR CLIC IZQUIERDO (Iniciar Arrastre) ---
			if event.pressed:
				# CASO A: Ya existe una abeja en esa posición -> Arrastrar la existente
				if celdas_ocupadas.has(tile_pos) and is_instance_valid(celdas_ocupadas[tile_pos]):
					abeja_arrastrada = celdas_ocupadas[tile_pos]
					tile_origen = tile_pos
					es_nueva_abeja = false
					get_viewport().set_input_as_handled()
					
				## CASO B: El tile está vacío -> Crear una abeja nueva para arrastrar
				#else:
					#abeja_arrastrada = bee_scene.instantiate()
					#tile_origen = tile_pos
					#es_nueva_abeja = true
					#
					#if abejas_container:
						#abejas_container.add_child(abeja_arrastrada)
					#else:
						#add_child(abeja_arrastrada)
						#
					#get_viewport().set_input_as_handled()

			# --- SOLTAR CLIC IZQUIERDO (Finalizar Arrastre) ---
			elif not event.pressed and abeja_arrastrada != null:
				# Restaurar el orden de dibujo original
				abeja_arrastrada.z_index = 0
				
				# Validar si el tile destino es adyacente o el mismo
				if es_adyacente(tile_origen, tile_pos):
					
					# CASO 1: Tile destino vacio
					if not celdas_ocupadas.has(tile_pos) or not is_instance_valid(celdas_ocupadas[tile_pos]):
						# Remover del origen si no era nueva
						if not es_nueva_abeja:
							celdas_ocupadas.erase(tile_origen)
						
						# Asignar la abeja al nuevo tile
						abeja_arrastrada.position = map_to_local(tile_pos)
						celdas_ocupadas[tile_pos] = abeja_arrastrada
						
					# CASO 2: Tile destino ocupado -> Intercambiar posiciones
					else:
						if es_nueva_abeja:
							# No podemos soltar una abeja nueva sobre una existente -> Cancelar
							cancelar_arrastre()
						else:
							var abeja_destino = celdas_ocupadas[tile_pos]
							
							# Intercambiar la abeja ocupante a la casilla de origen
							abeja_destino.position = map_to_local(tile_origen)
							celdas_ocupadas[tile_origen] = abeja_destino
							
							# Colocar la abeja arrastrada en la casilla de destino
							abeja_arrastrada.position = map_to_local(tile_pos)
							celdas_ocupadas[tile_pos] = abeja_arrastrada
				else:
					# El tile no era adyacente o no era válido -> Cancelar
					cancelar_arrastre()

				# Limpiar variables de control
				abeja_arrastrada = null
				tile_origen = null
				get_viewport().set_input_as_handled()
			
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if !event.pressed:
				var global_mouse_pos = get_global_mouse_position()
				var tile_pos = local_to_map(to_local(global_mouse_pos))
				# CASO B: El tile está vacío -> Crear una abeja nueva para arrastrar
				abeja_arrastrada = bee_scene.instantiate()
				tile_origen = tile_pos
				#es_nueva_abeja = true
				add_child(abeja_arrastrada)
					
				#get_viewport().set_input_as_handled()
			

func cancelar_arrastre() -> void:
	if not is_instance_valid(abeja_arrastrada):
		return
		
	if es_nueva_abeja:
		# Si era una abeja recién creada y el tiro fue inválido, se borra
		abeja_arrastrada.queue_free()
	else:
		# Si era una abeja existente, vuelve a su casilla de origen intacta
		abeja_arrastrada.position = map_to_local(tile_origen)

func es_adyacente(origen: Vector2i, destino: Vector2i) -> bool:
	var diff = (destino - origen).abs()
	# Permite arrastrar a casillas adyacentes (incluyendo permanecer en el mismo tile)
	return diff.x <= 1 and diff.y <= 1
