extends Camera2D

@export var smooth_speed := 8.0  # higher = faster camera movement

func _process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	global_position = global_position.lerp(target_pos, delta * smooth_speed)
