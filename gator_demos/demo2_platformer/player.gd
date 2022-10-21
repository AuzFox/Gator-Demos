extends KinematicBody

const GRAVITY: float = 24.0
const SPEED: float = 4.0
const JUMP_VELOCITY: float = 9.0

signal coin_collected

onready var mesh: MeshInstance = $MeshInstance

var velocity: Vector3 = Vector3.ZERO
var snap_vector: Vector3 = Vector3.UP
var input_vector: Vector2 = Vector2.ZERO

var coins: int = 0

func get_coin(value: int) -> void:
	coins += value
	emit_signal("coin_collected", coins)

func _physics_process(delta):
	# get movement vector (X and Z)
	input_vector.x = Input.get_axis("game_left", "game_right")
	input_vector.y = Input.get_axis("game_up", "game_down")
	input_vector = input_vector.normalized()
	
	# rotate player mesh
	if input_vector != Vector2.ZERO:
		var target: Vector3 = global_translation
		target.x += input_vector.x
		target.z += input_vector.y
		mesh.look_at(target, Vector3.UP)
	
	# handle jumping
	if is_on_floor():
		if Input.is_action_just_pressed("game_jump"):
			velocity.y = JUMP_VELOCITY
			snap_vector = Vector3.ZERO
		
		if snap_vector == Vector3.ZERO:
			snap_vector = Vector3.UP
	
	# set velocity
	velocity.x = input_vector.x * SPEED
	velocity.z = input_vector.y * SPEED
	velocity.y -= GRAVITY * delta
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP)
