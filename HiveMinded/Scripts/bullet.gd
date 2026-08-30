extends CharacterBody2D

var Direction: Vector2
var speed := 400
var sinEnemigoAtacado:bool=true


func _physics_process(delta: float) -> void:
	#velocity=Direction.normalized() * speed
	velocity.x = speed * 1
	if global_position.x >= 1200:
		#print("Destruyendo bala: ",global_position)
		queue_free()
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("La bala entro a un cuerpo: ", body.name)
	if body.is_in_group("GrupoEnemigos") and sinEnemigoAtacado:
		var vida = body.TakeDamage(1)
		sinEnemigoAtacado=false
		#print("Enemigo ",body.name, " recibe daño. Vida: ", vida)
		queue_free()
		
