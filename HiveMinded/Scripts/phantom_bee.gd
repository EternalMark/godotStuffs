extends CharacterBody2D

var espacioOcupado:bool=false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("GrupoEnemigos"):
		#print("Espacio Ocupado")
		espacioOcupado=true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("GrupoEnemigos"):
		#print("Libre")
		espacioOcupado=false
