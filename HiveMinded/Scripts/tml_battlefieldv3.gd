extends TileMapLayer

@onready var bee_scene =preload("res://Escenas/Abeja.tscn")
@onready var phantom_bee_scene =preload("res://Escenas/PhantomBee.tscn")
@onready var abejas_container = $"../../Bees"

var ubicacion_nueva_abeja=Vector2i(2, 1)
var phantom_bee_instance
# Diccionario para rastrear la abeja en cada casilla: Vector2i -> Node2D
var celdas_ocupadas: Dictionary = {}
# Variables para el estado de arrastre
var abeja_arrastrada: Node2D = null
var tile_origen = null

func _ready() -> void:
	colocar_abeja(ubicacion_nueva_abeja)
	GlobalGameState.cambioHito.connect(on_cambio_hito)

func _process(_delta: float) -> void:
	# Mientras estemos arrastrando una abeja, su posición sigue al ratón
	if is_instance_valid(abeja_arrastrada):
		phantom_bee_instance.global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton: 
		var global_mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(to_local(global_mouse_pos))
	
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if celdas_ocupadas.has(tile_pos) and is_instance_valid(celdas_ocupadas[tile_pos]) :
					abeja_arrastrada = celdas_ocupadas[tile_pos]
					tile_origen = tile_pos
					phantom_bee_instance = phantom_bee_scene.instantiate()
					abejas_container.add_child(phantom_bee_instance)
					get_viewport().set_input_as_handled()
			
			## Soltar mouse
			elif not event.pressed and abeja_arrastrada != null:
				## Restaurar el orden de dibujo original

				if phantom_bee_instance.espacioOcupado==false and tile_pos.x >= 3 and tile_pos.x <= 7 and tile_pos.y >= 2 and tile_pos.y <= 7:
					
					# CASO 1: Tile destino vacio
					if not celdas_ocupadas.has(tile_pos) or not is_instance_valid(celdas_ocupadas[tile_pos]):
						# Asignar la abeja al nuevo tile
						abeja_arrastrada.position = map_to_local(tile_pos)
						abeja_arrastrada.tile_pos=tile_pos
						celdas_ocupadas[tile_pos] = abeja_arrastrada
						celdas_ocupadas.erase(tile_origen)
						
					# CASO 2: Tile destino ocupado -> Intercambiar posiciones
					else:
						var abeja_destino = celdas_ocupadas[tile_pos]
						
						# Intercambiar la abeja ocupante a la casilla de origen
						abeja_destino.position = map_to_local(tile_origen)
						abeja_destino.tile_pos=tile_origen
						celdas_ocupadas[tile_origen] = abeja_destino
						
						# Colocar la abeja arrastrada en la casilla de destino
						abeja_arrastrada.position = map_to_local(tile_pos)
						abeja_arrastrada.tile_pos=tile_pos
						celdas_ocupadas[tile_pos] = abeja_arrastrada
				
				## Limpiar variables de control
				abeja_arrastrada = null
				tile_origen = null
				phantom_bee_instance.queue_free()
				phantom_bee_instance=null
				get_viewport().set_input_as_handled()

func colocar_abeja(tile_pos: Vector2i) -> void:
	var bee_instance = bee_scene.instantiate()
	bee_instance.position = map_to_local(tile_pos)
	bee_instance.tile_pos=tile_pos
	celdas_ocupadas[tile_pos] = bee_instance
	abejas_container.add_child(bee_instance)
	GlobalGameState.abejas_generadas+=1

func on_cambio_hito()->void:
	colocar_abeja(ubicacion_nueva_abeja)
