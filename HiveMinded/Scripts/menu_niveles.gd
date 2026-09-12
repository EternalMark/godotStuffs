extends Node

@onready var incrementos: CanvasLayer = $Incrementos

func _unhandled_input(event: InputEvent) -> void:
	# Detecta si se presiona la tecla ESC
	if event.is_action_pressed("boton_sube_niveles"):
		get_tree().paused = not get_tree().paused
		incrementos.visible= not incrementos.visible
