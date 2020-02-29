extends Node

func _ready():
	for i in range(0, 4):
		if i == 2: # Skip player 3 for no particular reason
			continue

		var render = $Splitscreen.add_player(i)
		var cam = Camera.new()
		render.viewport.add_child(cam)
		cam.translation = Vector3(0, 0, 5)
