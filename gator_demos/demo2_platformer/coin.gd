extends Sprite3D

export var properties: Dictionary
export var value: int = 1 # actual value of pickup

func _ready():
	if "type" in properties:
		# set pickup value (yellow = 1, red = 5)
		value = properties["type"] * 5
		
		# set correct sprite frame (yellow = 0, red = 1)
		frame = properties["type"] - 1

func _process(delta):
	rotate_y(-deg2rad(180) * delta)
