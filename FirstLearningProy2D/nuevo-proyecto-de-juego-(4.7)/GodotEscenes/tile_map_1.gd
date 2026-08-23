
extends Node2D

@onready var grid = $TilemapLayers/Foreground
@onready var cursor =$Sprite2D
#@onready var info_label = $CanvasLayer/Label
var cursor_pos = Vector2i(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_cursor_position()

var map_size = Vector2i(10, 6) # ajusta a tu tamaño
#var map_size = Vector2i(10, 10) # ajusta a tu tamaño

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var moved = false
	if Input.is_action_just_pressed("ui_right") and cursor_pos.x < map_size.x - 1:
		cursor_pos.x += 1
		moved = true
	elif Input.is_action_just_pressed("ui_left") and cursor_pos.x > 1:
		cursor_pos.x -= 1
		moved = true
	elif Input.is_action_just_pressed("ui_up") and cursor_pos.y > 1:
		cursor_pos.y -= 1
		moved = true
	elif Input.is_action_just_pressed("ui_down") and cursor_pos.y < map_size.y - 1:
		cursor_pos.y += 1
		moved = true

	if moved:
		update_cursor_position()


func update_cursor_position():
	cursor.position = grid.map_to_local(cursor_pos)
	
