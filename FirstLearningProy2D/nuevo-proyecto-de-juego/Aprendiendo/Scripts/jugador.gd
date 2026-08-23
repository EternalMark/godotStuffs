extends CharacterBody2D

var velocidad:int = 50
var direction=null
var directionY=null

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("ui_left","ui_right")
	directionY = Input.get_axis("ui_up","ui_down")
	velocity.x = direction * velocidad
	velocity.y = directionY * velocidad
	
	print("velocity",velocity,"\tdirection",direction)
	#velocity = direction * velocidad
	
	
	velocity.normalized()
	move_and_slide()
	
