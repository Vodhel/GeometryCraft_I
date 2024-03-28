extends CharacterBody2D
class_name Unit 

@export var hp 		 := 100.0
@export var speed_multiplier := 1.0
@onready var nav_agent = $NavigationAgent2D


var speed = 100 * speed_multiplier 
#@export var name 	 := "Name"
var is_Selected = false
var direction : Vector2
var aimed_position : Vector2
var state : int
var flag_move_and_attack : bool = false

var FLAG_hovering : bool =  false

# Called when the node enters the scene tree for the first time.
func _ready():
	state = 0
	direction = Vector2(0,0)
	aimed_position = Vector2(0,0)
	get_parent().give_global_order.connect(_on_global_order)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	
	print(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp == 0:
		queue_free()
		
	#Not sure it's needed here, but in case I'll try to put it in a FSM 
	match state:
		0:
			if(flag_move_and_attack):
				flag_move_and_attack = false
				state = 1
		1:
			if nav_agent.is_navigation_finished():
				state = 0
				velocity = Vector2.ZERO
			else:
				var target = nav_agent.get_next_path_position()
				direction = global_position.direction_to(target)
				var new_velocity = direction*speed
				nav_agent.set_velocity(new_velocity)
				
		_:
			state = 0
	move_and_slide()
	


# N'est plus nécessaire, à supprimer quand on aura plus besoin de débugg ça
func _input_event(_viewport, event, _shape_idx):
	if(event.is_action_pressed("selection")):
		print("clicked")


func _on_recieve_order(order : Array):
	print("order recieved" + name + "\n" + str(order))
	
	match order[0]:
		"move_and_attack": #For now straight line, but we'll have to find a way
							# to find path
			aimed_position = order[1]
			set_movement_target(aimed_position)
			print(aimed_position)
			(flag_move_and_attack) = true
		"disconnect":
			get_parent().give_order.disconnect(_on_recieve_order)
		_:
			pass

func _on_global_order(order : Array):
	
	match order[0]:
		"select": # Pas forcément une bonne méthode, j'arrive pas à trouver comment faire
			if(FLAG_hovering): # Trouvé !
				get_parent().give_order.connect(_on_recieve_order)
		_:
			pass


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func set_movement_target(movement_target: Vector2):
	nav_agent.set_target_position(movement_target)

func _on_mouse_shape_entered(shape_idx):
	FLAG_hovering = true
	print("in")
	
	
func _on_mouse_shape_exited(shape_idx):
	FLAG_hovering = false
	print("out")
	
