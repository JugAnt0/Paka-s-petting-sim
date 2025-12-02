extends Node2D


func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")
	SceneMemory.push_scene(scene_file_path)

func _on_black_d_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/panda's_minigame_selection.tscn")


func _on_orange_d_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/bellist's_minigame_selection.tscn")
	

func _on_black_n_white_d_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/flora's_minigame_selection.tscn")


func _on_siamese_d_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shanny's_minigame_selection.tscn")


func _on_go_back_pressed() -> void:
	var previous_scene = SceneMemory.pop_scene()
	if previous_scene != "":
		get_tree().change_scene_to_file(previous_scene)
