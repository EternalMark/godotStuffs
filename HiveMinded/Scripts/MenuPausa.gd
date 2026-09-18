extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	# Detecta si se presiona la tecla ESC
	if event.is_action_pressed("ui_cancel") and GlobalGameState.gameState==GameConstants.GAME_STATES.IN_PROGRESS:
		# Alterna el estado de pausa (si está activo lo quita, si no, lo activa)
		get_tree().paused = !get_tree().paused
		visible= not visible
		#$ColorRect.visible= not $ColorRect.visible
		#$Label.visible= not $Label.visible
		print("Boton esc presionado: ", get_tree().paused)
