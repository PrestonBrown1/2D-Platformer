extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(round($Timer.time_left))


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game.tscn")
