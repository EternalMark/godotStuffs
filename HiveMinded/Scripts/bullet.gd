extends CharacterBody2D

var Direction: Vector2
var speed := 400



func _physics_process(delta: float) -> void:
	#velocity=Direction.normalized() * speed
	velocity.x = speed * 1
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("La bala entro a un cuerpo: ", body.name)
	if body.is_in_group("GrupoEnemigos"):
		var vida = body.TakeDamage(1)
		print("Enemigo ",body.name, " recibe daño. Vida: ", vida)
		queue_free()
