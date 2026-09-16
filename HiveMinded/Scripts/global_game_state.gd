extends Node

# Variable global para contar los enemigos eliminados
var enemigos_derrotados: int = 0
var cantidad_enemigos:int=0
var hito_actual:int=0
var abejas_generadas:int=0
var hito_siguiente:int=10
var delay_generacion_enemigos:float=5.0
var monedas:int=0

#Las abejas se posicionan entre el 3 al 7
#Del 8 al 15 es el terreno
#Los enemigos aparecen en el 16

signal cambioHito
signal actualizaUI
signal findeljuego
signal inicializaJuego

var gameState:GameConstants.GAME_STATES = GameConstants.GAME_STATES.IN_PROGRESS

#
#enum GAME_STATES {
	#IN_PROGRESS,
	#ENDGAME
#}

const hitos = [5,2.5,2.0,1.5,1.0,0.5,0.4,0.3,0.2,0.1]

func cambio_hito()->void:
	hito_actual+=1
	self.delay_generacion_enemigos=hitos[hito_actual if hito_actual<=hitos.size()-1 else hitos.size()-1]
	cambioHito.emit()

func nuevo_enemigo_derrotado() -> void:
	print("Enemigo Derrotado")
	enemigos_derrotados += 1
	cantidad_enemigos-=1
	if enemigos_derrotados==10:
		cambio_hito()
		hito_siguiente=50
	elif enemigos_derrotados==hito_siguiente:
		hito_siguiente=hito_siguiente+40*hito_actual
		cambio_hito()
		print("Hito Siguiente: ",hito_siguiente)
		
	actualizaUI.emit()
	#var fecha = Time.get_datetime_dict_from_system()
	#var milisegundos = Time.get_ticks_msec() % 1000
	#print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [fecha["year"], fecha["month"], fecha["day"],fecha["hour"], fecha["minute"], fecha["second"],milisegundos],"\tEnemigos derrotados: \t", enemigos_derrotados)
	
func enemigo_en_goalzone()->void:
	gameState=GameConstants.GAME_STATES.ENDGAME
	print("Fin del juego emitido")
	findeljuego.emit()
	
func reiniciar_partida()->void:
	get_tree().paused = false
	enemigos_derrotados=0
	cantidad_enemigos=0
	hito_actual=0
	abejas_generadas=0
	hito_siguiente=10
	delay_generacion_enemigos=5.0
	monedas=0
	gameState = GameConstants.GAME_STATES.IN_PROGRESS
	inicializaJuego.emit()
