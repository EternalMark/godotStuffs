extends Node

@onready var siguiente_hito: Label = $SiguienteHito
@onready var puntos: Label = $Puntos
@onready var lbl_monedas: Label = $lblMonedas

func _ready() -> void:
	GlobalGameState.actualizaUI.connect(actualizaUI)


func actualizaUI()-> void:
	print("Actualizando UI")
	puntos.text = "Enemigos Derrotados: "+ str(GlobalGameState.enemigos_derrotados) 
	siguiente_hito.text = "Por derrotar: "+ str(GlobalGameState.hito_siguiente) 
	lbl_monedas.text = "Monedas: "+ str(GlobalGameState.monedas) 
