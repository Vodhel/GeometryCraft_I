extends CharacterBody2D
class_name Unit 

@export var hp 		 := 100.0
@export var speed_multiplier := 1.0

var speed = 100 * speed_multiplier 
#@export var name 	 := "Name"
var is_Selected = false
var direction : Vector2
var aimed_position : Vector2
var state : int
var flag_move_and_attack : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state = 0
	direction = Vector2(0,0)
	aimed_position = Vector2(0,0)
	get_parent().global_order.connect(_on_global_order)
	
	print(name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp == 0:
		queue_free()
		
	#Not sure it's needed here, but in case I'll try to put it in a FSM 
	match state:
		0:
			if(flag_move_and_attack):
				flag_move_and_attack = false
				state = 1
		1:
			velocity = direction*speed
			if((position-aimed_position).length() < 1):
				state = 0
				direction = Vector2(0,0)
				velocity = Vector2(0,0)
		_:
			state = 0
	move_and_slide()
	



func _input_event(_viewport, event, _shape_idx):
	if(event.is_action_pressed("selection")):
		print("clicked")
		# Y'a une erreur quand on double clic, je corrige pas car c'est une
		# manière de faire la connection qui est vouée à changer
		get_parent().give_order.connect(_on_recieve_order)
		get_parent().unselect.connect(_on_unselect)



func _on_recieve_order(order : Array):
	print("order recieved" + name + "\n" + str(order))
	
	match order[0]:
		"move_and_attack": #For now straight line, but we'll have to find a way
							# to find path
			aimed_position = order[1]
			direction = (aimed_position-position).normalized()
			flag_move_and_attack = true
		_:
			pass

func _on_unselect():
	get_parent().unselect.disconnect(_on_unselect)
	get_parent().give_order.disconnect(_on_recieve_order)

func _on_global_order(order : Array):
	
	match order[0]:
		"select": # Pas forcément une bonne méthode, j'arrive pas à trouver comment faire
			pass
		"disconnect":
			pass
		_:
			pass
	

