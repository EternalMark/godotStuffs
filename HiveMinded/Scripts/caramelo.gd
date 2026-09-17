extends CharacterBody2D

var aumentos:Caracteristicas
var costo:int
var caramel_type:GameConstants.CARAMEL_TYPE
var caramelName:String

func _ready() -> void:
	$name.text=str(caramelName)
	$costo.text=str("$")+str(costo)

#func setLabelName(lblName:String)->void:
	#caramelName.text=str(lblName)
