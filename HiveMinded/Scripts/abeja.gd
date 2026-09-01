extends CharacterBody2D

var vida: int =5
var tile_pos:Vector2i
var experiencia:int=0
#var movimiento:bool=true
@onready var lblVida:Label =$lblVida

func incrementaExperiencia(exp:int) -> void:
	experiencia+=exp
	print(" incrementa experiencia: ",experiencia)
	

func TakeDamage(damage:int)-> int:
	vida -=damage
	lblVida.text=str(vida)
	if vida <=0:
		Muerte()
	return vida 
	
func Muerte() -> void:
	print("Abeja Muere")
	queue_free()
