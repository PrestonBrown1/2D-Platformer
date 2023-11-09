extends Node2D

var velocity = Vector2.ZERO
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, -speed).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	var container = body.get_parent().get_parent()
	var player = get_node("/root/Game/Player")
	if container.name == "EnemyContainer":
		body.damage(-player.dmg)
		queue_free()
	elif container.name == "LevelContainer":
		queue_free()
