extends Node

@onready var enemy_scene = preload("res://Escenas/Wasp.tscn")
@onready var tilemap_layer: TileMapLayer = $"../Layers/tmlBattlefield"
@onready var lblPuntos: Label = $"../Puntos"

#var enemies=3
#var spawners = 5

var posiciones_tiles: Array[Vector2i] = [
	Vector2i(16, 2),
	Vector2i(16, 3),
	Vector2i(16, 4),
	Vector2i(16, 5),
	Vector2i(16, 6),
]
	
func _on_timer_spawner_timeout() -> void:
	#var numEnemies= randi_range(0,enemies)
	#var segundos = randi_range(0,100)
	#$TimerSpawner.wait_time=segundos
	#print("Spawneando ",numEnemies," enemigos"," Esperando: ")
	#print(" Esperando: ",segundos," segundos")
	#var enemyI = 
	#var tile_pos = local_to_map(to_local(spawn1))
	if not tilemap_layer:
		print("Falta asignar el TileMapLayer o la escena Spawner")
		return
	
	for tile_pos in posiciones_tiles:
		var generacion = randi_range(0,20)
		
		if generacion==1:
			var enemy=enemy_scene.instantiate()
			enemy.enemigo_muerto.connect(_on_enemigo_muerto)
			var pos_local = tilemap_layer.map_to_local(tile_pos)
			var pos_global = tilemap_layer.to_global(pos_local)
			
			enemy.global_position = pos_global
			add_child(enemy)
			
# Función que se ejecutará automáticamente cuando el enemigo emita 'enemigo_muerto'
func _on_enemigo_muerto() -> void:
	GlobalGameState.sumar_enemigo()
	lblPuntos.text = "Enemigos Derrotados: "+ str(GlobalGameState.enemigos_derrotados) 
	#print("¡Un enemigo ha muerto!  ", GlobalGameState.enemigos_derrotados)
	
	# Aquí incrementas tu contador local o ejecutas la lógica que necesites


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
