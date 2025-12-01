extends Camera2D
@onready var flora: CharacterBody2D = $"../Flora"



func _process(_delta: float) -> void:
	if flora.global_position.y < global_position.y:
		global_position.y = flora.global_position.y
