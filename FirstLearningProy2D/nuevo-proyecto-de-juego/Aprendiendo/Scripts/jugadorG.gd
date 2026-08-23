extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var vida:int =10
var swordDamage:int=2
@onready var lblVida:Label = $"../../Menu/CanvasLayer/lblVida"

func _ready() -> void:
	#Suma(10)
	lblVida.text="Vida: " + str(vida)
	
	
func _physics_process(delta: float) -> void: 
	#60 veces en un segundo
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
	GameOver()

func GameOver() -> void:
	if vida <=0:
		queue_free() #borra el objeto

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("spikesGroup"):
		vida -= 1
		lblVida.text="Vida: " + str(vida)
	
func RecibeDaño(damage:int)-> int:
	vida -=damage
	if vida <=0:
		vida=0
		lblVida.text="Game Over"
	else:
		lblVida.text="Vida: " + str(vida)
	return vida 
		
func _on_espada_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		body.RecibeDaño(swordDamage)
		

func _on_espada_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
