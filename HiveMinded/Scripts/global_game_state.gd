extends Node

# Variable global para contar los enemigos eliminados
var enemigos_derrotados: int = 0
#var iteraciones: int = 0
var cantidad_enemigos:int=0
var hito_actual:int=0
var abejas_generadas:int=0
var hito_siguiente:int=50

signal cambioHito

func nuevo_enemigo_derrotado() -> void:
	enemigos_derrotados += 1
	cantidad_enemigos-=1
	cambio_hito()
	
	
	#var fecha = Time.get_datetime_dict_from_system()
	#var milisegundos = Time.get_ticks_msec() % 1000
	#print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
		#fecha["year"], fecha["month"], fecha["day"],
		#fecha["hour"], fecha["minute"], fecha["second"],
		#milisegundos],"\tEnemigos derrotados: \t", enemigos_derrotados)

func cambio_hito()->void:
	#var hito_siguiente:int = 200 * int(pow(5, nivel - 2))
	if enemigos_derrotados==10:
			hito_actual+=1
			cambioHito.emit()
	elif enemigos_derrotados==hito_siguiente:
		hito_actual+=1
		cambioHito.emit()
		hito_siguiente=hito_siguiente+40*hito_actual
		print("Hito Siguiente: ",hito_siguiente)
		
	
	
