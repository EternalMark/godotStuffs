extends CharacterBody2D

var Direction: Vector2
#var speed := 400
#var sinEnemigoAtacado:bool=true
var owner_character: CharacterBody2D = null
var piercing:int=1


func _physics_process(delta: float) -> void:
	#velocity=Direction.normalized() * speed
	velocity.x = owner_character.bulletSpeed * 1
	if global_position.x >= 1200:
		#print("Destruyendo bala: ",global_position)
		queue_free()
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("La bala entro a un cuerpo: ", body.name)
	#if body.is_in_group("GrupoEnemigos") and sinEnemigoAtacado:
	if body.is_in_group("GrupoEnemigos"):
		var vidaEnemigo = body.TakeDamage(owner_character.bulletDamage)
		owner_character.incrementaExperiencia(1)
		if vidaEnemigo <=0:
			owner_character.incrementaExperiencia(2)
		#sinEnemigoAtacado=false
		#print("Enemigo ",body.name, " recibe daño. Vida: ", vida)
		piercing-=1
		if piercing <=0:
			queue_free()
