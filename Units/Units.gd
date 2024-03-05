extends Node2D
class_name Unit 

@export var hp 		 := 100.0
@export var velocity := 1.0
#@export var name 	 := "Name"
var is_Selected = false

signal clicked


# Called when the node enters the scene tree for the first time.
func _ready():
	print(name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		
	if hp == 0:
		queue_free()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if(event.is_action_pressed("left_click")):
		clicked.emit(name)
		
