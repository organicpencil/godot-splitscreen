extends Node

const PLAYER_RENDER_SCN = preload("player_render.tscn")
const PLAYER_VIEWPORT_SCN = preload("player_viewport.tscn")

var _renders = [null, null, null, null]
var player_count = 0

export var border_width = 4.0 setget set_border_width
export var vertical = true setget set_vertical

signal update_viewports

func _ready():
	get_tree().connect("screen_resized", self, "update_viewports")

func add_player(player_number : int):
	# Adds a new render overlay + viewport and returns the viewport. You must add the camera yourself.
	# To move the returned viewport to a different world:
	# var viewport = add_player(0)
	# viewport.get_parent().remove_child(viewport)
	# new_world.add_child(viewport)

	if player_number > 3 or player_number < 0:
		push_error("%d is not a valid player number. Possible values: 0, 1, 2, 3" % player_number)
		return

	if (_renders[player_number]):
		push_error("Player %d viewport already exists" % player_number)
		return

	var render = PLAYER_RENDER_SCN.instance()
	var viewport = PLAYER_VIEWPORT_SCN.instance()
	render.texture = viewport.get_texture()
	render.viewport = viewport
	render.player_number = player_number

	_renders[player_number] = render
	add_child(render)
	add_child(viewport)

	player_count += 1
	update_viewports()

	return render

func get_player(player_number : int):
	return _renders[player_number]

func update_viewports():
	var size_x = OS.window_size.x
	var size_y = OS.window_size.y
	var size = null

	if player_count == 1:
		size = OS.window_size
	elif player_count == 2:
		if vertical:
			size = Vector2(size_x / 2.0 - border_width / 2.0, size_y)
		else:
			size = Vector2(size_x, size_y / 2.0 - border_width / 2.0)
	else:
		size = Vector2(size_x / 2.0 - border_width / 2.0, size_y / 2.0 - border_width / 2.0)

	for render in _renders:
		if render:
			render.update_viewport(size)

	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	emit_signal("update_viewports", size)

func remove_player(player_number : int):
	if player_number > 3 or player_number < 0:
		push_warning("%d is not a valid player number. Possible values: 0, 1, 2, 3" % player_number)
		return

	if !_renders[player_number]:
		push_warning("Player %d viewport does not exist" % player_number)
		return

	_renders[player_number].viewport.queue_free()
	_renders[player_number].queue_free()
	_renders[player_number] = null

	player_count -= 1
	update_viewports()

func set_border_width(value : float):
	border_width = value
	update_viewports()

func set_vertical(value : bool):
	vertical = value
	update_viewports()