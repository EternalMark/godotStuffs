extends CharacterBody2D

var Direction: Vector2
#var speed := 400
#var sinEnemigoAtacado:bool=true
#var owner_character: CharacterBody2D = null
var caracteristicas:Caracteristicas
#var piercing:int=1

func _physics_process(delta: float) -> void:
	#velocity=Direction.normalized() * speed
	#velocity.x = owner_character.caracteristicas.bulletSpeed * 1
	velocity.x = caracteristicas.bulletSpeed * 1
	if global_position.x >= 1200:
		#print("Destruyendo bala: ",global_position)
		queue_free()
		
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("La bala entro a un cuerpo: ", body.name)
	if body.is_in_group("GrupoEnemigos"):
		var vidaEnemigo = body.TakeDamage(caracteristicas.bulletDamage)

		#region experiencia_Deprecada
		#owner_character.incrementaExperiencia(1)
		#if vidaEnemigo <=0:
			#owner_character.incrementaExperiencia(2)
		#endregion
		
		#sinEnemigoAtacado=false
		#print("Enemigo ",body.name, " recibe daño. Vida: ", vida)
		caracteristicas.bulletPiercing-=1
		if caracteristicas.bulletPiercing <=0:
			queue_free()
