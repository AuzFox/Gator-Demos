extends Sprite3D

onready var area: Area = $Area

export var properties: Dictionary
export var value: int = 1 # actual value of pickup

func _ready():
	if "type" in properties:
		var type: int = properties["type"]
		
		# set pickup value (yellow = 1, red = 5)
		value = 1 if type == 1 else 5
		
		# set correct sprite frame (yellow = 0, red = 1)
		frame = type - 1

func _process(delta):
	rotate_y(-deg2rad(180) * delta)

func _on_player_entered(body):
	body.get_coin(value)
	queue_free()
