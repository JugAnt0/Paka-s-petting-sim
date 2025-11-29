extends CharacterBody2D

@onready var cam: Camera2D = $"../Camera2D"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY := 900.0
const JUMP_SPEED := -500.0
const MOVE_SPEED := 200.0

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * MOVE_SPEED

	if direction != 0:
		animated_sprite.flip_h = direction < 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
		
	if velocity.y < 0:
		animated_sprite.play("jumping") 
	elif velocity.y > 0:
		animated_sprite.play("falling")  
	else:
		if direction == 0:
			animated_sprite.play("sit") 
		else:
			animated_sprite.play("run")   


	move_and_slide()
	var left_limit := -144
	var right_limit := 144

	if global_position.x > right_limit:
		global_position.x = left_limit
	elif global_position.x < left_limit:
		global_position.x = right_limit

	if global_position.y > cam.global_position.y + 200:
		get_tree().change_scene_to_file("res://scenes/flora's_sky_high_death_screen.tscn")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if velocity.y > 0:  
		velocity.y = JUMP_SPEED
		animated_sprite.play("jumping")
