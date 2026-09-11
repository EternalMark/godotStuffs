extends CharacterBody2D

var vida: int =5
var tile_pos:Vector2i
var puntosExperiencia:int=0
var nivelActual:int=1

#region bullet Aspects
var bulletDamage:float=1:
		set(v):
			bulletDamage = snappedf(v, 0.01)
var bulletSpeed:float=400:
		set(v):
			bulletSpeed = snappedf(v, 0.01)
var bulletCadence:float=1.0:
		set(v):
			bulletCadence = snappedf(v, 0.01)
var bulletPiercing:int=1

#endregion

#Cubica
const niveles=[8,27,64,125,216,343,512,729,1000,1331,1728,2197,2744,3375,4096,4913,5832,6859,8000]

#var movimiento:bool=true
@onready var lblVida:Label =$lblVida
@onready var lblExperiencia:Label =$lblExperiencia

func incrementaExperiencia(exp:int) -> void:
	puntosExperiencia+=exp
	lblExperiencia.text=str(nivelActual)+"\n"+str(bulletDamage)+"\n"+str(bulletSpeed)+"\n"+str(bulletCadence)+"\n"+str(puntosExperiencia)
	#print(" incrementa experiencia: ",experiencia)
	if puntosExperiencia>=niveles[nivelActual]:
		match randi_range(0,3):
			0:
				bulletDamage+=0.1
			1:
				bulletSpeed+=0.2
			2:
				bulletCadence*=0.9
				$bullets/TimerSpawnBullet.wait_time=bulletCadence
			3:
				bulletPiercing+=1
				bulletDamage*=0.7
				
		nivelActual+=1
	#var fecha = Time.get_datetime_dict_from_system()
	#var milisegundos = Time.get_ticks_msec() % 1000
	#print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
	#fecha["year"], fecha["month"], fecha["day"],
	#fecha["hour"], fecha["minute"], fecha["second"],
	#milisegundos]," Waittime: \t",$TimerSpawner.wait_time,"\tCantidad de enemigos: \t",GlobalGameState.cantidad_enemigos)

func TakeDamage(damage:int)-> int:
	vida -=damage
	lblVida.text=str(vida)
	if vida <=0:
		Muerte()
	return vida 
	
func Muerte() -> void:
	print("Abeja Muere")
	queue_free()
