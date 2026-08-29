extends Node

# Variable global para contar los enemigos eliminados
var enemigos_derrotados: int = 0



func sumar_enemigo() -> void:
	enemigos_derrotados += 1
	var fecha = Time.get_datetime_dict_from_system()
	var milisegundos = Time.get_ticks_msec() % 1000
	print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
		fecha["year"], fecha["month"], fecha["day"],
		fecha["hour"], fecha["minute"], fecha["second"],
		milisegundos],"\tEnemigos derrotados: \t", enemigos_derrotados)
