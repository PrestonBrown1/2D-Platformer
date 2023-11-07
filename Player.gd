extends CharacterBody2D

var health = 100
var dmg = 10
const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$Sprite.animation = "Fall"
	elif abs(velocity.x) > 0:
		$Sprite.animation = "Walk"
	else:
		$Sprite.animation = "Idle"

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		$Sprite.animation = "Jump"
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	floor_max_angle = deg_to_rad(60)

func damage(d):
	health += d
	if health <= 0:
		die()

func die():
	health = 100
	var global = get_node("/root/Global")
	global.updateLives(-1)
	position = Vector2(70, 490)
