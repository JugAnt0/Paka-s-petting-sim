extends CharacterBody2D

const GRAVITY : int = 500
const JUMPS_PEED : int = -150
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $"../DeathTimer"
func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	if is_on_floor():
		$RunCol.disabled = false
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMPS_PEED
			$AnimatedSprite2D.play("jump")
			
		elif Input.is_action_pressed( "duck"):
			$RunCol.disabled = true
			$AnimatedSprite2D.play("duck")
		
		else:
			$AnimatedSprite2D.play("run")
		
	move_and_slide()
	
func die():
	Engine.time_scale = 0.5
	timer.start()

func _on_death_timer_timeout():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/panda's_automatic_platformer's_death_scene.tscn")
