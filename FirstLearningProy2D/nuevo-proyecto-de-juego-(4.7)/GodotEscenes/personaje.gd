class_name Personaje

extends StaticBody2D

##const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
const ESCENA_BULLET = preload("res://GodotEscenes/bullet.tscn")
var shootSpeed = 200
var contador = 0


func launch_bullet():
	var instancia_bullet = ESCENA_BULLET.instantiate()
	instancia_bullet.position=$Hand.position 
	instancia_bullet.position.x+=1
	add_child(instancia_bullet)
	


func _on_timer_timeout() -> void:
	launch_bullet()
