extends Node

@onready var bullet_scene = preload("res://Escenas/Bullet.tscn")
#@onready var bullet = $"."

func _on_timer_spawn_bullet_timeout() -> void:
	var b=bullet_scene.instantiate()
	print("Generando Bullet")
	add_child(b)
	b.global_position=$"..".global_position
	#b.Direction = $"..".global_position
	
