extends CanvasLayer
const POINTER = preload("uid://dgjrvxgmrf0lq")
const MOUSE_1 = preload("uid://deowjibv8av4d")
var button_type = ""


func _on_texture_button_pressed() -> void:
	button_type = "GoBack"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")


func _on_texture_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(MOUSE_1, Input.CURSOR_ARROW, Vector2(16,16))


func _on_texture_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(POINTER, Input.CURSOR_ARROW, Vector2(16,16))


func _on_fade_timer_timeout() -> void:
	Input.set_custom_mouse_cursor(POINTER, Input.CURSOR_ARROW, Vector2(16,16))
	if button_type == "GoBack":
		
		var previous_scene = SceneMemory.pop_scene()
		get_tree().change_scene_to_file(previous_scene)
