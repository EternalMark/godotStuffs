extends CharacterBody2D

var vida: int =5
var tile_pos:Vector2i
var puntosExperiencia:int=0
var nivelActual:int=1

var caracteristicas:Caracteristicas
#Cubica
const niveles=[8,27,64,125,216,343,512,729,1000,1331,1728,2197,2744,3375,4096,4913,5832,6859,8000]

#var movimiento:bool=true
@onready var lblVida:Label =$lblVida
@onready var lblExperiencia:Label =$lblExperiencia

func _ready() -> void:
	#bulletDamage:float = 0.0,bulletSpeed:float = 0.0,bulletPiercing:int = 0.0,bulletCadence:float = 0.0)
	caracteristicas= Caracteristicas.new(1,400,1,1.0)
	verCaracteristicas()
	#caracteristicas.bulletDamage=1
	#caracteristicas.bulletSpeed=400
	#caracteristicas.bulletPiercing=1
	#caracteristicas.bulletCadence=1.0

#func incrementaExperiencia(exp:int) -> void:
	#puntosExperiencia+=exp
	#lblExperiencia.text=str(nivelActual)+"\n"+str(bulletDamage)+"\n"+str(bulletSpeed)+"\n"+str(bulletCadence)+"\n"+str(puntosExperiencia)
	##print(" incrementa experiencia: ",experiencia)
	#if puntosExperiencia>=niveles[nivelActual]:
		#match randi_range(0,3):
			#0:
				#bulletDamage+=0.1
			#1:
				#bulletSpeed+=0.2
			#2:
				#bulletCadence*=0.9
				#$bullets/TimerSpawnBullet.wait_time=bulletCadence
			#3:
				#bulletPiercing+=1
				#bulletDamage*=0.7
				#
		#nivelActual+=1
	#var fecha = Time.get_datetime_dict_from_system()
	#var milisegundos = Time.get_ticks_msec() % 1000
	#print("%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
	#fecha["year"], fecha["month"], fecha["day"],
	#fecha["hour"], fecha["minute"], fecha["second"],
	#milisegundos]," Waittime: \t",$TimerSpawner.wait_time,"\tCantidad de enemigos: \t",GlobalGameState.cantidad_enemigos)

func mejoraCaracteristicas(c:Caracteristicas):
	caracteristicas.bulletDamage+=c.bulletDamage
	caracteristicas.bulletSpeed+=c.bulletSpeed
	caracteristicas.bulletCadence+=c.bulletCadence
	caracteristicas.bulletPiercing+=c.bulletPiercing
	verCaracteristicas()
	

func TakeDamage(damage:int)-> int:
	vida -=damage
	lblVida.text=str(vida)
	if vida <=0:
		Muerte()
	return vida 
	
func Muerte() -> void:
	print("Abeja Muere")
	queue_free()

func verCaracteristicas()->void:
	lblExperiencia.text=str(caracteristicas.bulletDamage)+"\n"+str(caracteristicas.bulletSpeed)+"\n"+str(caracteristicas.bulletCadence)+"\n"+str(caracteristicas.bulletCadence)
