class_name bulletScript

extends Area2D

@export var speed: float = 200.0
var direction: Vector2 = Vector2.RIGHT

#func _ready():
	#connect("area_entered", Callable(self, "_on_area_entered"))
	#$VisibleOnScreenNotifier2D.connect("screen_exited", Callable(self, "_on_screen_exited"))

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area):
	print("Choqué")
	queue_free()  # Destruye la bala al chocar
	if area.has_method("damage_received"):
		area.damage_received()

#func _on_area_exited(area: Area2D) -> void:
	#queue_free() 
	#print("Bullet eliminadoooo")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() 
	print("Bullet eliminadoooo")
