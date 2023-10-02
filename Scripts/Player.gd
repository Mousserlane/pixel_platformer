extends CharacterBody2D

@export var JUMP_FORCE = -100
@export var RELEASE_FORCE = -50
@export var ACCELERATION = 40
@export var MAX_SPEED = 50
@export var FRICTION = 40
@export var GRAVITY = 4

func _physics_process(delta):
	var input = Vector2.ZERO
	apply_gravity()

	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	
	if input.x == 0:
		apply_friction();
	else:
		move_to(input.x);

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") && velocity.y < RELEASE_FORCE:
			velocity.y = RELEASE_FORCE
		
		if velocity.y > 0:
			velocity.y += GRAVITY - 2
	
	move_and_slide()
	
func apply_gravity():
	velocity.y += GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func move_to(direction):
	velocity.x = move_toward(direction, MAX_SPEED * direction, ACCELERATION)
