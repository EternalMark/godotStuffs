extends Node2D

@onready var grid: Node2D = $Control/SubViewportContainer/SubViewport/TileMapLayer
@onready var cursor: Node2D = $Sprite2D
@onready var info_label: Label = $CanvasLayer/Label

var cursor_pos: Vector2 = Vector2(0, 0)
var cell_size: Vector2 = Vector2(32, 32)

func _ready():
	update_cursor_position()
	#show_tile_info(cursor_pos)

func _process(delta):
	var moved := false
	if Input.is_action_just_pressed("ui_right"):
		cursor_pos.x += 1
		moved = true
	elif Input.is_action_just_pressed("ui_left"):
		cursor_pos.x -= 1
		moved = true
	elif Input.is_action_just_pressed("ui_up"):
		cursor_pos.y -= 1
		moved = true
	elif Input.is_action_just_pressed("ui_down"):
		cursor_pos.y += 1
		moved = true

	if moved:
		update_cursor_position()
		#show_tile_info(cursor_pos)

func update_cursor_position():
	# Posiciona el cursor en el centro del tile dentro del SubViewport
	var world_pos = cursor_pos * cell_size + cell_size / 2
	cursor.position = $Control/SubViewportContainer.position + world_pos

#func show_tile_info(cell_pos: Vector2i):
	#var tile_data = grid.get_cell_tile_data(cell_pos)
	#if tile_data == null:
		#info_label.text = "Celda " + str(cell_pos) + ": vacía"
	#else:
		#var source_id = grid.get_cell_source_id(cell_pos)
		#info_label.text = "Celda " + str(cell_pos) + " | Source ID: " + str(source_id)


func _on_grid_overlay_draw() -> void:
	pass # Replace with function body.
