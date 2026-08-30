extends Node

@onready var enemy_scene = preload("res://Escenas/Wasp.tscn")
@onready var tilemap_layer: TileMapLayer = $"../Layers/tmlBattlefield"
@onready var lblPuntos: Label = $"../Puntos"

var ajusteCantidad:float=2
#var enemies=3
#var spawners = 5

var posiciones_tiles: Array[Vector2i] = [
	Vector2i(16, 2),
	Vector2i(16, 3),
	Vector2i(16, 4),
	Vector2i(16, 5),
	Vector2i(16, 6),
	Vector2i(16, 7),
]
	
	
func _ready() -> void:
	genera_enemigo()
	
func _on_timer_spawner_timeout() -> void:
	if not tilemap_layer:
		print("Falta asignar el TileMapLayer o la escena Spawner")
		return
		
	genera_enemigo()
	
	if GlobalGameState.enemigos_derrotados>=50 and GlobalGameState.enemigos_derrotados<200:
		ajusteCantidad=1
	if GlobalGameState.enemigos_derrotados>=200 and GlobalGameState.enemigos_derrotados<500:
		ajusteCantidad=0.5
	if GlobalGameState.enemigos_derrotados>=500:
		ajusteCantidad=0.1
	
	#var epsilon=GlobalGameState.enemigos_derrotados*0.08
	#var epsilon=sin(GlobalGameState.enemigos_derrotados)+GlobalGameState.enemigos_derrotados*0.5
	#f(x)=5 sen(x*0.1-5)+0.5
	#var epsilon=5*sin(GlobalGameState.enemigos_derrotados*0.1-5)+0.5
	var epsilon=5/(max(GlobalGameState.enemigos_derrotados,10)*0.1)
	#$TimerSpawner.wait_time=max(0.5,$TimerSpawner.wait_time*(0.99-epsilon))
	$TimerSpawner.wait_time=max(ajusteCantidad,epsilon)
	print("Waittime: \t",$TimerSpawner.wait_time,"\tEpsilon: \t",epsilon,"\tCantidad de enemigos: \t",GlobalGameState.cantidad_enemigos)

			
# Función que se ejecutará automáticamente cuando el enemigo emita 'enemigo_muerto'
func _on_enemigo_muerto() -> void:
	GlobalGameState.sumar_enemigo()
	lblPuntos.text = "Enemigos Derrotados: "+ str(GlobalGameState.enemigos_derrotados) 
	#print("¡Un enemigo ha muerto!  ", GlobalGameState.enemigos_derrotados)
	
	# Aquí incrementas tu contador local o ejecutas la lógica que necesites

func genera_enemigo():
	var generacion = randi_range(0,5)
	var enemy=enemy_scene.instantiate()
	enemy.enemigo_muerto.connect(_on_enemigo_muerto)
	enemy.tile_pos=posiciones_tiles[generacion]
	var pos_local = tilemap_layer.map_to_local(posiciones_tiles[generacion])
	var pos_global = tilemap_layer.to_global(pos_local)
	enemy.global_position = pos_global
	GlobalGameState.cantidad_enemigos+=1
	add_child(enemy)

# Ejemplo en GDScript para calcular el tiempo del siguiente spawn
func obtener_tiempo_siguiente_enemigo(tiempo_juego: float) -> float:
	var base_time: float = 3.0       # Tiempo promedio entre spawns (3 segundos)
	var amplitud: float = 1.5        # Cuánto acelera/desacelera la ola
	var frecuencia: float = 0.1      # Vel. de cambio entre oleadas
	
	# La función sin() variará rítmicamente entre -1.5 y +1.5 segundos
	var wave: float = amplitud * sin(frecuencia * tiempo_juego)
	
	# Variación aleatoria pura de +/- 0.5 segundos para no ser predecible
	var noise: float = randf_range(-0.5, 0.5)
	
	# Aseguramos que el tiempo nunca sea cero o negativo
	return max(0.5, base_time + wave + noise)
