class_name GameController

extends Node2D

const ESCENA_ZOMBIE = preload("res://GodotEscenes/ZombieCharacter.tscn")


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
##func sumar_puntaje


#func _on_genera_zombies_timeout() -> void:
	#print("Genera Zombies")
	#var instancia_zombie = ESCENA_ZOMBIE.instantiate()
	#instancia_zombie.position=$"../Spawners/SpawnerEscene".position 
	##instancia_zombie.position.x+=1
	#add_child(instancia_zombie)
	


func _on_timer_timeout() -> void:
	print("Genera Zombies")
	var instancia_zombie = ESCENA_ZOMBIE.instantiate()
	instancia_zombie.position=$"../Spawners/SpawnerEscene".position 
	#instancia_zombie.position.x+=1
	add_child(instancia_zombie)
