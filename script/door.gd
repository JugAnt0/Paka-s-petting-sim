extends Node2D

const MOUSE = preload("uid://deowjibv8av4d")

var bt = null

const POINTER = preload("uid://dgjrvxgmrf0lq")


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		bt = "door_opened"
		$fade_transition.show()
		$fade_transition/FadeTimer.start()
		$fade_transition/AnimationPlayer.play("fade_in")
		


func _on_area_2d_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(MOUSE, Input.CURSOR_ARROW, Vector2(16,16))


func _on_area_2d_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(POINTER, Input.CURSOR_ARROW, Vector2(16,16))


func _on_fade_timer_timeout() -> void:
	Input.set_custom_mouse_cursor(POINTER, Input.CURSOR_ARROW, Vector2(16,16))
	get_tree().change_scene_to_file("res://scenes/start_game.tscn")
