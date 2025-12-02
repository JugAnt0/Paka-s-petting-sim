extends Node2D

var button_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")
	SceneMemory.push_scene(scene_file_path)


	


func _on_go_back_pressed() -> void:
	button_type = "GoBack"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	

func _on_fade_timer_timeout():
	
	if button_type == "GoBack":
		
		var previous_scene = SceneMemory.pop_scene()
		if previous_scene != "":
			get_tree().change_scene_to_file(previous_scene)
