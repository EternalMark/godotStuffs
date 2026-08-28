extends Node

@onready var enemy_scene = preload("res://Escenas/Wasp.tscn")
@onready var tilemap_layer: TileMapLayer = $"../Layers/tmlBattlefield"

var enemies=3
var spawners = 5

var posiciones_tiles: Array[Vector2i] = [
	Vector2i(20, 2),
	Vector2i(20, 3),
	Vector2i(20, 4),
	Vector2i(20, 5),	
	Vector2i(20, 6),	
	Vector2i(20, 7),	
	Vector2i(20, 9),	
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
			
			var pos_local = tilemap_layer.map_to_local(tile_pos)
			var pos_global = tilemap_layer.to_global(pos_local)
			
			enemy.global_position = pos_global
			add_child(enemy)
