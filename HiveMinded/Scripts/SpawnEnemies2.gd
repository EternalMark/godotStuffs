extends Node

@onready var enemy_scene = preload("res://Escenas/Wasp.tscn")

@onready var spawn1 = $Spawn1
@onready var spawn2 = $Spawn2
@onready var spawn3 = $Spawn3
@onready var spawn4 = $Spawn4
@onready var spawn5 = $Spawn5
@onready var spawn6 = $Spawn6
@onready var spawn7 = $Spawn7
@onready var spawn8 = $Spawn8

var enemies=3

func _on_timer_spawner_timeout() -> void:
	#var numEnemies= randi_range(0,enemies)
	var segundos = randi_range(0,100)
	$TimerSpawner.wait_time=segundos
	#print("Spawneando ",numEnemies," enemigos"," Esperando: ")
	#print(" Esperando: ",segundos," segundos")
	#var enemyI = 
	#var tile_pos = local_to_map(to_local(spawn1))
	
	spawn1.add_child(enemy_scene.instantiate())
	spawn2.add_child(enemy_scene.instantiate())
	spawn3.add_child(enemy_scene.instantiate())
	spawn4.add_child(enemy_scene.instantiate())
	spawn5.add_child(enemy_scene.instantiate())
	spawn6.add_child(enemy_scene.instantiate())
	spawn7.add_child(enemy_scene.instantiate())
	spawn8.add_child(enemy_scene.instantiate())
	#for i in range(1,numEnemies):
		#spawn1.add_child(enemyI)
