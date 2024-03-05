extends Control

@export var game_manager : GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	game_manager.game_paused = false


func _on_back_to_menu_pressed():
	game_manager.game_paused = false
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()
