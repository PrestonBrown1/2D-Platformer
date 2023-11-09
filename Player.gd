extends CharacterBody2D

var health = 100
var dmg = 10
const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var bullet = load("res://bullet1.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if not ($Sprite.animation == "Shoot" and $Sprite.is_playing()):
			$Sprite.animation = "Fall"
			$Sprite.play()
	elif not ($Sprite.animation == "Shoot" and $Sprite.is_playing()):
		if abs(velocity.x) > 0:
			$Sprite.animation = "Walk"
			$Sprite.play()
		else:
			$Sprite.animation = "Idle"
			$Sprite.play()

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		$Sprite.animation = "Jump"
		velocity.y = JUMP_VELOCITY
		
	#Handle Shooting
	if Input.is_action_just_pressed("Shoot"):
		$Sprite.stop()
		$Sprite.animation = "Shoot"
		$Sprite.play()
		shoot()
	

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
	
func shoot():
	var mousePosition = get_global_mouse_position()
	var projectiles = get_node("/root/Game/Projectiles")
	var newBullet = bullet.instantiate()
	newBullet.position = global_position
	
	var angle = atan((global_position.y - mousePosition.y) / (mousePosition.x - global_position.x))
	if mousePosition.y < global_position.y and mousePosition.x < global_position.x:
		angle *= -1
		angle = deg_to_rad(180) - angle
	elif mousePosition.y > global_position.y and mousePosition.x < global_position.x:
		angle += deg_to_rad(180)
	
	newBullet.rotation -= angle - deg_to_rad(90)
	#print("Angle: " + str(rad_to_deg(angle)))
	#print("Rotation: " + str(rad_to_deg(newBullet.rotation)))
	
	projectiles.add_child(newBullet) 
