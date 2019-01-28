extends TextureRect

var viewport
var player_number

func _ready():
	assert(viewport)
	assert(player_number != null)

func update_viewport(size):
	rect_size = size

	var size_x = OS.window_size.x
	var size_y = OS.window_size.y
	var border_width = get_parent().border_width
	var player_count = get_parent().player_count

	if player_count == 1:
		rect_position = Vector2(0, 0)

	elif player_count == 2:
		if get_parent().vertical:
			if player_number == 0:
				rect_position = Vector2(0, 0)
			else:
				rect_position = Vector2(size.x + border_width, 0)
		else:
			if player_number == 0:
				rect_position = Vector2(0, 0)
			else:
				rect_position = Vector2(0, size.y + border_width)
	else:
		match player_number:
			0: rect_position = Vector2(0, 0)
			1: rect_position = Vector2(size.x + border_width, 0)
			2: rect_position = Vector2(0, size.y + border_width)
			3: rect_position = Vector2(size.x + border_width, size.y + border_width)

	viewport.size = size