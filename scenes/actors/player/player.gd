extends CharacterBody2D


var gravity_vec : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector", Vector2(0, 1))
var gravity_mag : int = ProjectSettings.get_setting("physics/2d/default_gravity", 980)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
