extends CharacterBody2D

@export var max_charge_time: float = 1.5
@export var min_jump_force: float = 150.0
@export var max_jump_force: float = 1200.0
@export var gravity: float = 2000.0
@export var friction: float = 800.0 
@export var horizontal_jump_speed: float = 220.0

var charging: bool = false
var charge_timer: float = 0.0
var direction: int = 1 
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		
		if abs(velocity.x) > 0.0:
			var stop_amount := friction * delta
			if abs(velocity.x) <= stop_amount:
				velocity.x = 0.0
			else:
				velocity.x -= sign(velocity.x) * stop_amount
				
		if Input.is_action_just_pressed("jump"):
			charging = true
			charge_timer = 0.0
			
		if charging:
			if Input.is_action_pressed("move_left"):
				direction = -1
			elif Input.is_action_pressed("move_right"):
				direction = 1
				
	if charging and Input.is_action_just_released("jump"):
		charging = false
		
		var t: float = charge_timer / max_charge_time
		t = clamp(t, 0.0, 1.0)
		
		var jump_force: float = lerp(min_jump_force, max_jump_force, t)
		
		velocity.y = -jump_force
		velocity.x = direction * horizontal_jump_speed
		
	if charging:
		charge_timer += delta
		charge_timer = min(charge_timer, max_charge_time)
		
	move_and_slide()
