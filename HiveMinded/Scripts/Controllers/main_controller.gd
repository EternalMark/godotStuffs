extends Node

@onready var siguiente_hito: Label = $CanvasLayer/SiguienteHito
@onready var puntos: Label = $CanvasLayer/Puntos
@onready var lbl_monedas: Label = $CanvasLayer/lblMonedas
@onready var menu_pausa: CanvasLayer = $MenuPausa
@onready var menu_fin_juego: CanvasLayer = $MenuFinJuego

func _ready() -> void:
	GlobalGameState.gameState=GameConstants.GAME_STATES.IN_PROGRESS
	GlobalGameState.actualizaUI.connect(actualizaUI)
	GlobalGameState.findeljuego.connect(findeljuego)
	GlobalGameState.reiniciar_partida()

func actualizaUI()-> void:
	print("Actualizando UI")
	puntos.text = "Enemigos Derrotados: "+ str(GlobalGameState.enemigos_derrotados) 
	siguiente_hito.text = "Por derrotar: "+ str(GlobalGameState.hito_siguiente) 
	lbl_monedas.text = "Monedas: "+ str(GlobalGameState.monedas) 

func findeljuego()->void:
	print("Fin del juego en maincontroller")
	get_tree().paused = true
	menu_fin_juego.visible=true
	
