extends Node

var level = 1
var lives = 3
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateLevel():
	var game = get_node("/root/Game")
	var levelContainer = get_node("/root/Game/LevelContainer")
	var lvlScn = get_node("/root/Game/LevelContainer/Level" + str(level))
	lvlScn.queue_free()
	level += 1
	lvlScn = load("res://Levels/level" + str(level) + ".tscn")
	var newScn = lvlScn.instantiate()
	levelContainer.add_child(newScn)
	var player = get_node("/root/Game/Player")
	player.position = Vector2(70, 490)

func updateLives(l):
	lives += l
	
	if lives < 0:
		get_tree().change_scene_to_file("res://end_game.tscn")

func getScore():
	return score
	
func updateScore(s):
	score += s
