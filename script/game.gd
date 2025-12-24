extends Node2D
@onready var i: TextureButton = $"/root/Info/i"
@onready var f = $"/root/FishManager/GUI"
var button_type = ""
var pointer = preload("res://assets/sprites/pointer.png")
var cat = preload("res://assets/sprites/Cat-cursor.png")

func _on_bellist_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(cat, Input.CURSOR_ARROW, Vector2(16,16))


func _on_bellist_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16,16))

func _ready() -> void:
	SceneMemory.push_scene(scene_file_path)
	i.hide()
	f.hide()
func _on_start_button_pressed():
	button_type = "start"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	

func _on_characters_button_pressed():
	button_type = "characters"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	

func _on_exit_button_pressed():
	get_tree().quit()
	


func _on_fade_timer_timeout() -> void:
	i.show()
	f.show()
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/start_game.tscn")
		
	elif button_type == "characters":
		get_tree().change_scene_to_file("res://scenes/characters.tscn")
