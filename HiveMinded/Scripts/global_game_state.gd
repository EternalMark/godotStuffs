extends Node

# Variable global para contar los enemigos eliminados
var enemigos_derrotados: int = 0

func sumar_enemigo() -> void:
	enemigos_derrotados += 1
	#lblPuntos.text = "Puntos: " + str(enemigos_derrotados)
	#lblPuntos.text 
	print("Enemigos derrotados: ", enemigos_derrotados)
