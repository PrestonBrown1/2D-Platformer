extends Sprite2D
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lives = global.lives
	if lives < 2:
		queue_free()
