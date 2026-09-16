extends Node

@onready var tml_battlefield: TileMapLayer = $tmlBattlefield
@onready var tml_mochila: TileMapLayer = $tmlMochila

@onready var bee_scene =preload("res://Escenas/Abeja.tscn")
@onready var phantom_bee_scene =preload("res://Escenas/PhantomBee.tscn")
@onready var abejas_container = $"../Bees"

@onready var caramelo_scene =preload("res://Escenas/caramelo.tscn")
@onready var caramelos_container = $"../Caramelos"

var abeja_arrastrada: Node2D = null
var caramelo_arrastrado: Node2D = null

var celdas_ocupadas: Dictionary = {}
var celdas_ocupadas_caramelos: Dictionary = {}

var ubicacion_nueva_abeja=Vector2i(3, 1)
var ubicacion_nueva_caramelo=Vector2i(2, 5)

var phantom_bee_instance
var phantom_caramelo_instance

var tile_origen_abeja = null
var tile_origen_caramelo = null

func _ready() -> void:
	colocar_abeja(ubicacion_nueva_abeja)
	GlobalGameState.cambioHito.connect(on_cambio_hito)
	
	var c= Caracteristicas.new(0.5,0.0,0.0,0.0)
	colocar_caramelo(ubicacion_nueva_caramelo,c,GameConstants.FIFTY)
	
func _process(_delta: float) -> void:
	# Mientras estemos arrastrando una abeja, su posición sigue al ratón
	if is_instance_valid(abeja_arrastrada):
		#pass
		phantom_bee_instance.global_position = tml_battlefield.get_global_mouse_position()
	if is_instance_valid(caramelo_arrastrado):
		#pass
		phantom_caramelo_instance.global_position = tml_mochila.get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton: 
		cambia_posicion_abeja(event)
		cambia_posicion_caramelo(event)

func cambia_posicion_abeja(event: InputEvent)-> void:
	
		var global_mouse_pos = tml_battlefield.get_global_mouse_position()
		var tile_pos = tml_battlefield.local_to_map(tml_battlefield.to_local(global_mouse_pos))
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if celdas_ocupadas.has(tile_pos) and is_instance_valid(celdas_ocupadas[tile_pos]):
					abeja_arrastrada = celdas_ocupadas[tile_pos]
					tile_origen_abeja = tile_pos
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
						abeja_arrastrada.position = tml_battlefield.map_to_local(tile_pos)
						abeja_arrastrada.tile_pos=tile_pos
						celdas_ocupadas[tile_pos] = abeja_arrastrada
						celdas_ocupadas.erase(tile_origen_abeja)
						
					# CASO 2: Tile destino ocupado -> Intercambiar posiciones
					else:
						var abeja_destino = celdas_ocupadas[tile_pos]
						
						# Intercambiar la abeja ocupante a la casilla de origen
						abeja_destino.position = tml_battlefield.map_to_local(tile_origen_abeja)
						abeja_destino.tile_pos=tile_origen_abeja
						celdas_ocupadas[tile_origen_abeja] = abeja_destino
						
						# Colocar la abeja arrastrada en la casilla de destino
						abeja_arrastrada.position = tml_battlefield.map_to_local(tile_pos)
						abeja_arrastrada.tile_pos=tile_pos
						celdas_ocupadas[tile_pos] = abeja_arrastrada
				
				## Limpiar variables de control
				abeja_arrastrada = null
				tile_origen_abeja = null
				phantom_bee_instance.queue_free()
				phantom_bee_instance=null
				get_viewport().set_input_as_handled()

func cambia_posicion_caramelo(event: InputEvent)-> void:
		var global_mouse_pos = tml_mochila.get_global_mouse_position()
		var tile_pos = tml_mochila.local_to_map(tml_mochila.to_local(global_mouse_pos))
		var tile_pos_bee = tml_battlefield.local_to_map(tml_battlefield.to_local(global_mouse_pos))

		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if celdas_ocupadas_caramelos.has(tile_pos) and is_instance_valid(celdas_ocupadas_caramelos[tile_pos]):
					caramelo_arrastrado = celdas_ocupadas_caramelos[tile_pos]
					tile_origen_caramelo = tile_pos
					phantom_caramelo_instance = phantom_bee_scene.instantiate()
					caramelos_container.add_child(phantom_caramelo_instance)
					get_viewport().set_input_as_handled()
			
			## Soltar mouse
			elif not event.pressed and caramelo_arrastrado != null:
				## Restaurar el orden de dibujo original

				#if phantom_bee_instance.espacioOcupado==false and tile_pos.x >= 3 and tile_pos.x <= 7 and tile_pos.y >= 2 and tile_pos.y <= 7:
					
				# CASO 1: Tile destino vacio
				if not celdas_ocupadas.has(tile_pos_bee) or not is_instance_valid(celdas_ocupadas[tile_pos_bee]):
					## Asignar la abeja al nuevo tile
					#caramelo_arrastrado.position = tml_mochila.map_to_local(tile_pos)
					#celdas_ocupadas_caramelos[tile_pos] = caramelo_arrastrado
					#celdas_ocupadas_caramelos.erase(tile_origen_caramelo)
					pass
				## CASO 2: Tile destino ocupado -> Intercambiar posiciones
				else:
					var abeja = celdas_ocupadas[tile_pos_bee]
					
					
					if GlobalGameState.monedas >= caramelo_arrastrado.costo:
						abeja.mejoraCaracteristicas(caramelo_arrastrado.aumentos)
						GlobalGameState.monedas -=caramelo_arrastrado.costo
					
					#var caramelo_destino = celdas_ocupadas_caramelos[tile_pos]
					## Intercambiar la abeja ocupante a la casilla de origen
					#caramelo_destino.position = tml_mochila.map_to_local(tile_origen_caramelo)
					#celdas_ocupadas_caramelos[tile_origen_caramelo] = caramelo_destino
					## Colocar la abeja arrastrada en la casilla de destino
					#caramelo_arrastrado.position = tml_mochila.map_to_local(tile_pos)
					#celdas_ocupadas_caramelos[tile_pos] = caramelo_arrastrado
				
				## Limpiar variables de control
				caramelo_arrastrado = null
				tile_origen_caramelo = null
				phantom_caramelo_instance.queue_free()
				phantom_caramelo_instance=null
				get_viewport().set_input_as_handled()

func colocar_abeja(tile_pos: Vector2i) -> void:
	var bee_instance = bee_scene.instantiate()
	bee_instance.position = tml_battlefield.map_to_local(tile_pos)
	bee_instance.tile_pos=tile_pos
	celdas_ocupadas[tile_pos] = bee_instance
	abejas_container.add_child(bee_instance)
	GlobalGameState.abejas_generadas+=1

func colocar_caramelo(tile_pos: Vector2i,c:Caracteristicas,costo:int) -> void:
	var caramelo_instance = caramelo_scene.instantiate()
	caramelo_instance.position = tml_mochila.map_to_local(tile_pos)
	caramelo_instance.aumentos=c
	caramelo_instance.costo=costo
	#caramelo_instance.tile_pos=tile_pos
	celdas_ocupadas_caramelos[tile_pos] = caramelo_instance
	caramelos_container.add_child(caramelo_instance)
	#GlobalGameState.abejas_generadas+=1

func on_cambio_hito()->void:
	pass
	#colocar_abeja(ubicacion_nueva_abeja)
