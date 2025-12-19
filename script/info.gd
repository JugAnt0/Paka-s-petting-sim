extends CanvasLayer



const p = preload("uid://dgjrvxgmrf0lq")
const m = preload("uid://deowjibv8av4d")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	Input.set_custom_mouse_cursor(p, Input.CURSOR_ARROW, Vector2(16,16))
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_texture_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(m, Input.CURSOR_ARROW, Vector2(16,16))


func _on_texture_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(p, Input.CURSOR_ARROW, Vector2(16,16))
