extends Node

@onready var bullet_scene = preload("res://Escenas/Bullet.tscn")
@onready var bee: CharacterBody2D = owner

func _on_timer_spawn_bullet_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("GrupoEnemigos")
	for enemy in enemies:
		if enemy.tile_pos.y == $"..".tile_pos.y:
			#b.owner_character=bee
			#b.piercing = bee.bulletPiercing
			add_child(creaBullet())
			#bee.incrementaExperiencia(1)
			
			break

func creaBullet() -> Node:
	var b=bullet_scene.instantiate()
	#b.owner_character=bee
	#b.piercing = bee.caracteristicas.bulletPiercing
	b.caracteristicas = bee.caracteristicas
	b.global_position=$"..".global_position
	return b
