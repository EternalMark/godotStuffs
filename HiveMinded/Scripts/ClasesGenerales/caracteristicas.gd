class_name Caracteristicas

#region bullet Aspects
var bulletDamage:float=1:
		set(v):
			bulletDamage = snappedf(v, 0.01)
var bulletSpeed:float=400:
		set(v):
			bulletSpeed = snappedf(v, 0.01)
var bulletCadence:float=1.0:
		set(v):
			bulletCadence = snappedf(v, 0.01)
var bulletPiercing:int=1
#endregion

func _init(bulletDamage:float = 0.0,bulletSpeed:float = 0.0,bulletPiercing:int = 0.0,bulletCadence:float = 0.0) -> void:
	self.bulletDamage = bulletDamage
	self.bulletSpeed = bulletSpeed
	self.bulletPiercing = bulletPiercing
	self.bulletCadence = bulletCadence
