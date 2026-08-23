extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var player=null
var label=null
var movimiento:bool=true
var playerCollition:bool = false

var vida: int =5
var damage: int = 3

func _ready() -> void:
	player=get_node("/root/Node2D/Jugador/jugador1") #Obtiene un nodo pasandole la ruta de un nodo en tiempo de ejecucion

func _physics_process(delta: float) -> void:
	if player != null and movimiento:
		#Ubicamos la direccion del jugador a partir de este enemigo
		var direction= global_position.direction_to(player.global_position) 
		velocity = direction * SPEED
		move_and_slide()
	Muerte()

func Attack (player:CharacterBody2D, damage: float) -> void:
	#player.vida -=damage
	var vidarestante =player.RecibeDaño(damage)
	#print("VidaRestante: ",vidarestante)
	$Timer.start()
	
func Muerte() -> void:
	if vida <=0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="jugador1":
		Attack(body,damage)
		playerCollition = true
		movimiento=false
	else:
		print("Enemy choco con otra cosa")

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Se fue Body:",body.name)
	if body.name=="jugador1":
		playerCollition = false
		movimiento=true
		$Timer.stop()

func _on_timer_timeout() -> void:
	print("Se ejecuta timer de enemigo")
	if player!=null:
		if playerCollition :
			Attack(player,damage)
	else:
		$Timer.stop()

func RecibeDaño(damage:int)-> int:
	vida -=damage
	#if vida <=0:
		#vida=0
	print("Vida Enemigo:", vida)
	movimiento=false
	$TimerMovimiento.start()
	return vida 
	


func _on_movimiento_timeout() -> void:
	movimiento=true
	$TimerMovimiento.stop()
	
