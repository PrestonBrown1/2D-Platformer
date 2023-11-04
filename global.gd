extends Node

var level = 1
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateLevel():
	var game = get_node("/root/Game")
	var lvlScn = get_node("/root/Game/Level" + str(level))
	lvlScn.queue_free()
	level += 1
	lvlScn = load("res://Levels/level" + str(level) + ".tscn")
	var newScn = lvlScn.instantiate()
	game.add_child(newScn)
	var player = get_node("/root/Game/Player")
	player.position = Vector2(70, 490)

func updateLives(l):
	lives += l
	print(lives)
