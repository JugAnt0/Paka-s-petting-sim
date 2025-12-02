extends CharacterBody2D

var speed := 300.0

func _physics_process(_delta: float) -> void:
	var d := 0.0

	if Input.is_action_pressed("move_left"):
		d -= 1
	if Input.is_action_pressed("move_right"):
		d += 1

	velocity.x = d * speed
	move_and_slide()
