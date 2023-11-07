extends CharacterBody2D

var health = 10
var dmg = 10
const SPEED = 150
var player = null


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player = get_node("/root/Game/Player")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var distanceToPlayer = getDistanceToPlayer()
	
	if abs(distanceToPlayer) <= 800 and abs(distanceToPlayer) >= 100:
		move()
	elif abs(distanceToPlayer) > 800:
		$AnimatedSprite2D.stop()
		velocity.x = 0
	elif abs(distanceToPlayer) < 100:
		attack()

	move_and_slide()

func move():
	if getDistanceToPlayer() < 0:
		velocity.x = -SPEED * (getDistanceToPlayer() / getDistanceToPlayer())
	else:
		velocity.x = SPEED * (getDistanceToPlayer() / getDistanceToPlayer())
	
	if $AnimatedSprite2D.is_playing(): return
	else:
		$AnimatedSprite2D.play("Walk")

func getDistanceToPlayer():
	var playerPos = player.global_position
	var distanceToPlayerX = (playerPos.x - global_position.x)
	var distanceToPlayerY = (playerPos.y - global_position.y)
	var distanceToPlayer = 0
	if distanceToPlayerX < 0:
		distanceToPlayer -= sqrt(distanceToPlayerX ** 2 + distanceToPlayerY ** 2)
	else:
		distanceToPlayer += sqrt(distanceToPlayerX ** 2 + distanceToPlayerY ** 2)
	return distanceToPlayer
	
func attack():
	if $AnimatedSprite2D.animation == "Attack" and $AnimatedSprite2D.is_playing(): return
	else:
		$AnimatedSprite2D.play("Attack")
		player.damage(-dmg)
