extends Node

@onready var bullet_scene = preload("res://Escenas/Bullet.tscn")
#@onready var enemies=$Enemies

#@onready var bee: CharacterBody2D = $".."
#@onready var tilemap_layer: TileMapLayer =$Layers/tmlBattlefield
#@onready var bullet = $"."

func _on_timer_spawn_bullet_timeout() -> void:
	#var enemies=$Enemies
	print ($"..".tile_pos)
	#var pos_local = tilemap_layer.map_to_local($"..".global_position)
	#var pos_global = tilemap_layer.to_global(pos_local)
	#enemy.global_position = pos_global
	var enemies = get_tree().get_nodes_in_group("GrupoEnemigos")
	#print (enemies)
	#for enemy in enemies.get_children():
	for enemy in enemies:
		#print("HOLA ", enemy)	
		#print("Tile_pos ", enemy.tile_pos)	
		print("Revisando enemigos.  LineaAparicion: ",enemy.tile_pos,"  pos_local", $"..".tile_pos)
		if enemy.tile_pos.y == $"..".tile_pos.y:
			var b=bullet_scene.instantiate()
			add_child(b)
			b.global_position=$"..".global_position
			break
			
