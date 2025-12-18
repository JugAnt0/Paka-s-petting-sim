extends Area2D
@onready var bellist: CharacterBody2D = $"../Bellist"
@onready var death_timer: Timer = $"../DeathTimer"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_timer: Timer = $AnimTimer
@onready var speed_timer: Timer = $"../SpeedTimer"
@onready var gui: CanvasLayer = $"/root/FishManager/GUI"
@onready var col: CollisionShape2D = $CollisionShape2D

var velocity = Vector2.ZERO

func _ready() -> void:
	anim.play("in_air")
	
	
func _physics_process(delta: float) -> void:
	position += velocity * delta



func _on_body_entered(body):
	anim.play("fell")
	velocity = Vector2.ZERO
	anim_timer.start()

	if body.name == "Bellist":
		Engine.time_scale = 0.2
		death_timer.start()
		
	elif body.name == "mini_clouds" or body.name == "TileMapLayer":
		col.queue_free()
		


func _on_death_timer_timeout() -> void:
	gui.hide()
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/node_2d_bellist's_rain_dodge_death_scene.tscn")


func _on_anim_timer_timeout() -> void:
	queue_free()


func _on_speed_timer_timeout() -> void:
	print("Adding speed...")
	Engine.time_scale += 0.1
	
