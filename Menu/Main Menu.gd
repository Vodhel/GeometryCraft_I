extends Control

@export var Moving_Background : bool
@export_range(0,1) var Background_Speed : float
@export_range(0,1) var Brackground_Force : float

var center : Vector2
@onready var background = $Background_Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Moving_Background):
		center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Moving_Background):
		var tween = create_tween()
		
		var offset = (center - get_local_mouse_position())*2*Brackground_Force
		tween.tween_property(background, "position", offset, 2-2*Background_Speed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://test_area.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	pass # Replace with function body.

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()


func _on_item_rect_changed():
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	
