
class_name Main

extends Node2D

@onready var grid = $Grid/TileMapLayer   # TileMapLayer dentro del TileMap
@onready var cursor = $Cursor
#@onready var info_label = $CanvasLayer/InfoLabel
@onready var info_label:Label = $CanvasLayer/Label

var cell_size = Vector2(32, 32)
var cursor_pos = Vector2i(0, 0)
var texto:String = "No has presionado"

func _ready():
	update_cursor_position()
	show_tile_info(cursor_pos)
	#texto="hola"

func _process(delta):
	var moved = false
	if Input.is_action_just_pressed("ui_right"):
		cursor_pos.x += 1
		#texto = "Derecha"
		info_label.texto = "Derecha"
		moved = true
	elif Input.is_action_just_pressed("ui_left"):
		cursor_pos.x -= 1
		#texto = "Izquierda"
		moved = true
	elif Input.is_action_just_pressed("ui_up"):
		cursor_pos.y -= 1
		#texto = "Arriba"
		moved = true
	elif Input.is_action_just_pressed("ui_down"):
		cursor_pos.y += 1
		#texto = "Abajo"
		moved = true

	if moved:
		update_cursor_position()
		show_tile_info(cursor_pos)



func update_cursor_position():
	cursor.position = grid.map_to_local(cursor_pos)

func show_tile_info(cell_pos: Vector2i):
	var tile_data = grid.get_cell_tile_data(cell_pos)
	if tile_data == null:
		info_label.text = "Celda " + str(cell_pos) + ": vacía"
	else:
		var source_id = grid.get_cell_source_id(cell_pos)
		info_label.text = "Celda " + str(cell_pos) + " | Source ID: " + str(source_id)
