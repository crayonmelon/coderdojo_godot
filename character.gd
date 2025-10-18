class_name main_player extends CharacterBody3D

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var animation_player_buisness_wiggle: AnimationPlayer = $AnimationPlayer

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var player_paused: bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if player_paused:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var input_dir := Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	print(input_dir.x, input_dir.y)
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#if direction has any value
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animated_sprite_3d.play("walk")
		
		if not animation_player_buisness_wiggle.is_playing():
			animation_player_buisness_wiggle.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animated_sprite_3d.play("idle")
		animation_player_buisness_wiggle.stop()
		

	move_and_slide()
