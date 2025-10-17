extends TextureRect

var viewport
var player_number

func _ready():
	assert(viewport)
	assert(player_number != null)

func update_viewport(viewportSize):
	set_deferred("size", viewportSize)
	
	var size_x = DisplayServer.window_get_size().x
	var size_y = DisplayServer.window_get_size().y
	var border_width = get_parent().border_width
	var player_count = get_parent().player_count

	if player_count == 1:
		position = Vector2(0, 0)

	elif player_count == 2:
		if get_parent().vertical:
			if player_number == 0:
				position = Vector2(0, 0)
			else:
				position = Vector2(viewportSize.x + border_width, 0)
		else:
			if player_number == 0:
				position = Vector2(0, 0)
			else:
				position = Vector2(0, viewportSize.y + border_width)
	else:
		match player_number:
			0: position = Vector2(0, 0)
			1: position = Vector2(viewportSize.x + border_width, 0)
			2: position = Vector2(0, viewportSize.y + border_width)
			3: position = Vector2(viewportSize.x + border_width, viewportSize.y + border_width)

	viewport.size = viewportSize
