extends Label
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	text = "Health: " + str(player.health)
