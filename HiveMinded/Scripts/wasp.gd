extends CharacterBody2D

const SPEED = 50.0

var vida: int =5
var movimiento:bool=true

func _physics_process(delta: float) -> void:
	if movimiento:
		velocity.x = SPEED * -1
		move_and_slide()

func Muerte() -> void:
	if vida <=0:
		queue_free()
		
		
func TakeDamage(damage:int)-> int:
	vida -=damage
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
