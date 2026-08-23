extends Node

@onready var enemy = preload("res://Aprendiendo/escenas/Enemy.tscn")
@onready var spawn1 = $spawn1
var player= null
var enemies=3

func _ready() -> void:
	player=get_node("/root/Node2D/Jugador/jugador1") #Obtiene un nodo pasandole la ruta de un nodo en tiempo de ejecucion

func _on_timer_spawner_timeout() -> void:
	if player!=null:
		var enemyI = enemy.instantiate()
		var numEnemies= randi_range(0,enemies)
		print("Spawneando ",numEnemies," enemigos")
		#for i in range(1,numEnemies):
			#spawn1.add_child(enemyI)
		
