extends Label
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var score = global.getScore()
	text = "Score: " + str(score)
