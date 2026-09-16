extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	# Detecta si se presiona la tecla ESC
	if event.is_action_pressed("ui_accept") and GlobalGameState.gameState==GlobalGameState.GAME_STATES.ENDGAME:
		print("FIN DEL JUEGO - PRESIONANDO ENTER...")
		# Alterna el estado de pausa (si está activo lo quita, si no, lo activa)
		get_tree().change_scene_to_file("res://Escenas/Menus/MenuPrincipal.tscn")
		#$ColorRect.visible= not $ColorRect.visible
		#$Label.visible= not $Label.visible
		#print("Boton esc presionado: ", get_tree().paused)
