class_name ZombieScript

extends Area2D

@export var speed: float = 100.0
var direction: Vector2 = Vector2.LEFT
var VIDA = 3

func _process(delta):
	position += direction * speed * delta

#func _on_area_entered(area):
	#queue_free()  # Destruye el zombie

func damage_received():
	print("Daño recibido")
	VIDA-=1
	if VIDA <= 0: 
		queue_free()
	
