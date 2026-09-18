extends Node

@onready var enemy_scene = preload("res://Escenas/Wasp.tscn")
#@onready var tilemap_layer: TileMapLayer = $"../Layers/tmlBattlefield"
@onready var tml_battlefield: TileMapLayer = $"../Layers/tmlBattlefield"

#@onready var lblPuntos =$"../Puntos"
#@onready var lblSiguienteHito= $"../CanvasLayer/SiguienteHito"
#@onready var lbl_monedas: Label = $"../lblMonedas"

#var ajusteCantidad:float=2
#var enemies=3
#var spawners = 5

var posiciones_tiles: Array[Vector2i] = [
	Vector2i(13, 1),
	Vector2i(13, 2),
	Vector2i(13, 3),
	Vector2i(13, 4),
	Vector2i(13, 5),
	Vector2i(13, 6),
]
	
func _ready() -> void:
	genera_enemigo()
	#lblSiguienteHito.text = "Por derrotar: "+ str(GlobalGameState.hito_siguiente) 
	
func _on_timer_spawner_timeout() -> void:
	if not tml_battlefield:
		print("Falta asignar el TileMapLayer o la escena Spawner")
		return
	if GlobalGameState.gameState==GameConstants.GAME_STATES.IN_PROGRESS: 
		genera_enemigo()


# Función que se ejecutará automáticamente cuando el enemigo emita 'enemigo_muerto'
func _on_enemigo_muerto(posicionGlobal) -> void:
	#region GeneraDrop
	var tile_pos=tml_battlefield.local_to_map(tml_battlefield.to_local(posicionGlobal))
	print("Enemigo muerto. Posicion: ",tile_pos)
	if tile_pos.x > GameConstants.ENEMY_POSX_FAR:
		GlobalGameState.monedas+=GameConstants.DROP_COINS_FAR
	elif tile_pos.x > GameConstants.ENEMY_POSX_NEAR: 
		GlobalGameState.monedas+=GameConstants.DROP_COINS_NEAR
	else:
		GlobalGameState.monedas+=GameConstants.DROP_COINS_CLOSER
	#endregion
	
	GlobalGameState.nuevo_enemigo_derrotado()

#func _on_enemy_on_goalzone()->void:
	#print("Señal emitida de fin del juego")
	#
	#pass

func genera_enemigo():
	var generacion = randi_range(0,5)
	var enemy=enemy_scene.instantiate()
	enemy.enemigo_muerto.connect(_on_enemigo_muerto)
	#enemy.enemigo_on_goalzone.connect(_on_enemy_on_goalzone)
	#enemy.enemigo_muerto.connect(GlobalGameState._on_enemigo_muerto)
	enemy.tile_pos=posiciones_tiles[generacion]
	var pos_local = tml_battlefield.map_to_local(posiciones_tiles[generacion])
	var pos_global = tml_battlefield.to_global(pos_local)
	enemy.global_position = pos_global
	GlobalGameState.enemigos_generados+=1
	add_child(enemy)
	$TimerSpawner.wait_time=max(0.1,GlobalGameState.delay_generacion_enemigos)
	var fecha = Time.get_datetime_dict_from_system()
	var milisegundos = Time.get_ticks_msec() % 1000
	print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [fecha["year"], fecha["month"], fecha["day"],fecha["hour"], fecha["minute"], fecha["second"],milisegundos]," Waittime: \t",$TimerSpawner.wait_time,"\tCantidad de enemigos: \t",GlobalGameState.enemigos_generados)
	if GlobalGameState.enemigos_generados>=GlobalGameState.hito_siguiente:
		GlobalGameState.gameState=GameConstants.GAME_STATES.LAST_ENEMY
		print("Ultimo enemigo Generado")


# Ejemplo en GDScript para calcular el tiempo del siguiente spawn
func obtener_tiempo_siguiente_enemigo(tiempo_juego: float) -> float:
	var base_time: float = 3.0       # Tiempo promedio entre spawns (3 segundos)
	var amplitud: float = 1.5        # Cuánto acelera/desacelera la ola
	var frecuencia: float = 0.1      # Vel. de cambio entre oleadas

	# La función sin() variará rítmicamente entre -1.5 y +1.5 segundos
	var wave: float = amplitud * sin(frecuencia * tiempo_juego)
	
	# Variación aleatoria pura de +/- 0.5 segundos para no ser predecible
	var noise: float = randf_range(-0.5, 0.5)
	
	# Aseguramos que el tiempo nunca sea cero o negativo
	return max(0.5, base_time + wave + noise)

func enemigo_llego_a_meta()-> void:
	pass
