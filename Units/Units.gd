extends Node2D
class_name Unit 

@export var hp 		 := 100.0
@export var velocity := 1.0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		hp = 0
	if hp == 0:
		queue_free()
