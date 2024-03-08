extends Node2D


var circle_preload = preload("res://Units/Circle/Circle.tscn")
var state : int
var previous_state : int # debugg
var gray_path # Hideux, trouver un moment de rendre ça propre un jour
var list_unit : Array

#This way unit just connect to this signal when selected and we can define each 
# order as an array
signal give_order(order : Array) 

#So unit know when unselection is done
signal unselect

#For the ones that should work on the press of a button and to select
signal global_order(order : Array)



# Called when the node enters the scene tree for the first time.
func _ready():
	print(list_unit)
	state = 0
	previous_state = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if previous_state != state: #debug
		print(state)
		previous_state = state
		
	#A FSM to rule the player, might change
	match state:
		0:
			if Input.is_action_just_pressed("build"):
				state = 1
				unselect.emit()
				var grey_circle = load("res://Units/Circle/gray_circle.tscn").instantiate()
				add_child(grey_circle)
				print(get_parent().get_tree_string_pretty())
				
			if(Input.is_action_just_pressed("move_and_attack")):
				give_order.emit(["move_and_attack", get_global_mouse_position()])
		1:
			if Input.is_action_just_pressed("selection"):
				var circle = circle_preload.instantiate()
				
				circle.position = get_global_mouse_position()
				add_child(circle)
			
			if Input.is_action_just_pressed("build"):
				state = 0
				get_node("GrayCircle").queue_free()
				
		_: # If other, return to initial, safety measure
			state = 0
	

	
	