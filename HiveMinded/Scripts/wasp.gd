extends CharacterBody2D

const SPEED = 10.0

var vida: int =5
var movimiento:bool=true
var beeCollition:bool=false
var beeAtacada = null
@onready var lblVida:Label =$lblVida
signal enemigo_muerto

func _physics_process(delta: float) -> void:
	if movimiento:
		velocity.x = SPEED * -1
		move_and_slide()

func Muerte() -> void:
	if vida <=0:
		enemigo_muerto.emit()
		queue_free()
		
		
func TakeDamage(damage:int)-> int:
	vida -=damage
	lblVida.text=str(vida)
	if vida <=0:
		#vida=0
		Muerte()
		#print("Vida Enemigo:", vida)
	else:
		movimiento=false
		$TimerMovimiento.start()
	return vida 

func _on_timer_movimiento_timeout() -> void:
	movimiento=true
	$TimerMovimiento.stop()

func _on_area_damage_body_entered(body: Node2D) -> void:
	#print("La bala entro a un cuerpo: ", body.name)
	if body.is_in_group("GrupoAbejas"):
		movimiento=false
		beeCollition=true
		beeAtacada=body
		var vida = beeAtacada.TakeDamage(1)
		$TimerAtacando.start()
		#queue_free()
		#print("Abeja ",body.name, " recibe daño. Vida: ", vida)

func _on_area_damage_body_exited(body: Node2D) -> void:
	if body.is_in_group("GrupoAbejas"):
		movimiento=true
		beeCollition=false
		beeAtacada=null
		$TimerAtacando.stop()

func _on_timer_atacando_timeout() -> void:
	if beeCollition:
		var vida = beeAtacada.TakeDamage(1)
		print("Abeja ",beeAtacada.name, " recibe daño por TIMEOUT. Vida: ", vida)
