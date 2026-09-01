extends Node

# Variable global para contar los enemigos eliminados
var enemigos_derrotados: int = 0
#var iteraciones: int = 0
var cantidad_enemigos:int=0
var hito_actual:int=0
var abejas_generadas:int=0
var hito_siguiente:int=50
var delay_generacion_enemigos:float=5.0

signal cambioHito

func nuevo_enemigo_derrotado() -> void:
	enemigos_derrotados += 1
	cantidad_enemigos-=1
	if enemigos_derrotados==10:
		cambio_hito()
	elif enemigos_derrotados==hito_siguiente:
		hito_siguiente=hito_siguiente+40*hito_actual
		cambio_hito()
		print("Hito Siguiente: ",hito_siguiente)
	#var fecha = Time.get_datetime_dict_from_system()
	#var milisegundos = Time.get_ticks_msec() % 1000
	#print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
		#fecha["year"], fecha["month"], fecha["day"],
		#fecha["hour"], fecha["minute"], fecha["second"],
		#milisegundos],"\tEnemigos derrotados: \t", enemigos_derrotados)

func cambio_hito()->void:
	hito_actual+=1
	GlobalGameState.delay_generacion_enemigos=GlobalGameState.delay_generacion_enemigos/2
	cambioHito.emit()
	
