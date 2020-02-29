# godot-splitscreen
This addon provides the boilerplate for a standard 1-4 player splitscreen viewport setup. It can add/remove players on-the-fly and responds to changes in window size.

Supports Godot 3.2

## Usage
First, instance `res://addons/organicpencil.splitscreen/splitscreen.tscn` somewhere in the tree.  
Set desired `border_width` and `vertical`.

And then...
```gdscript
# Add a player. Possible values 0 - 3. Returns a TextureRect with some extra goodies attached
var render = $Splitscreen.add_player(0)

# Assign a camera to the viewport
var cam = Camera.new() # Probably want to store a ref to this camera so you can move it later
render.viewport.add_child(cam)

# Add your HUD
var hud = preload("res://path/to/my_hud.tscn").instance()
render.add_child(hud)

# Player 2
render = $Splitscreen.add_player(1)
...
```

Cleaning up when a player leaves:
```gdscript
$Splitscreen.remove_player(0)
```

The viewport can be moved to a different parent if you need to change worlds
```gdscript
var viewport = $Splitscreen.get_player(0).viewport
viewport.get_parent().remove_child(viewport)
my_other_world.add_child(viewport)
```

Random notes:
- The borders aren't actually drawn, so you can just throw whatever behind it to change the color.
- You may want to change the settings in `addons/organicpencil.splitscreen/player_viewport.tscn`, depending on your project.
