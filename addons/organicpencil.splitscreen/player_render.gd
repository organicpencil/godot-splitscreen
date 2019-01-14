extends TextureRect

var viewport
var player_number

func _ready():
	assert(viewport)
	assert(player_number != null)

	get_tree().connect("screen_resized", self, "update_viewport")

func update_viewport():
	var player_count = get_parent().player_count

	var size_x = OS.window_size.x
	var size_y = OS.window_size.y
	var border = get_parent().border_width

	if player_count == 1:
		rect_size = OS.window_size
		rect_position = Vector2(0, 0)

	elif player_count == 2:
		if get_parent().vertical:
			rect_size = Vector2(size_x / 2.0 - border / 2.0, size_y)

			if player_number == 0:
				rect_position = Vector2(0, 0)
			else:
				rect_position = Vector2(rect_size.x + border, 0)
		else:
			rect_size = Vector2(size_x, size_y / 2.0 - border / 2.0)

			if player_number == 0:
				rect_position = Vector2(0, 0)
			else:
				rect_position = Vector2(0, rect_size.y + border)


	else:
		rect_size = Vector2(size_x / 2.0 - border / 2.0, size_y / 2.0 - border / 2.0)

		match player_number:
			0: rect_position = Vector2(0, 0)
			1: rect_position = Vector2(rect_size.x + border, 0)
			2: rect_position = Vector2(0, rect_size.y + border)
			3: rect_position = Vector2(rect_size.x + border, rect_size.y + border)

	viewport.size = rect_size