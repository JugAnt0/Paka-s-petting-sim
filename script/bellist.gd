extends CharacterBody2D


@onready var anim := $AnimatedSprite2D
@onready var timer := $StateTimer

var state := "idle_stand"
var speed := 20
var direction := 1   # 1 = right, -1 = left
var left_bound := -112
var right_bound := 124




func _ready():
	change_state("idle_stand")


func change_state(new_state):
	state = new_state

	match new_state:
		"idle_stand":
			anim.play("stand")
			timer.start(randf_range(1.0, 3.0))

		"sit_down":
			anim.play("sit_down")

		"idle_sit":
			anim.play("sit")
			timer.start(randf_range(3.0, 6.0))

		"stand_up":
			anim.play("stand_up")

		"wander":
			anim.play("walk")
			# choose left or right
			direction = 1 if randf() > 0.5 else -1
			timer.start(randf_range(2.0, 6.0))


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.y = 0

	# Move only while wandering
	if state == "wander":
		velocity.x = direction * speed
	else:
		velocity.x = 0

	# FLIP always based on movement
	anim.flip_h = direction < 0

	# BOUNDS — VERY IMPORTANT:
	# (Turn around immediately and DO NOT change state)
	if global_position.x < left_bound:
		global_position.x = left_bound
		direction = 1
		anim.flip_h = false
	elif global_position.x > right_bound:
		global_position.x = right_bound
		direction = -1
		anim.flip_h = true

	move_and_slide()


func _on_state_timer_timeout():
	match state:
		"idle_stand":
			if randf() < 0.4:
				change_state("sit_down")
			else:
				change_state("wander")

		"idle_sit":
			if randf() < 0.5:
				change_state("stand_up")
			else:
				change_state("wander")

		"wander":
			# stop wandering without choosing a new direction yet
			change_state("idle_stand")


func _on_animated_sprite_2d_animation_finished():
	match anim.animation:
		"sit_down":
			change_state("idle_sit")
		"stand_up":
			change_state("idle_stand")





func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16,16))
		get_tree().change_scene_to_file("res://scenes/flora's_minigame_selection.tscn")

var pointer = preload("res://assets/sprites/pointer.png")
var cat = preload("res://assets/sprites/Cat-cursor.png")


	
	
	
	



func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(cat, Input.CURSOR_ARROW, Vector2(16,16))


func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16,16))
