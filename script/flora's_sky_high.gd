extends Node2D

@onready var flora: CharacterBody2D = $Flora
@onready var camera: Camera2D = $Camera2D
@onready var gui: CanvasLayer = $"/root/FishManager/GUI"
@onready var fishes: Area2D = $fish

@onready var platform_still: Node2D = $PlatformStill
@onready var platform_moving: Node2D = $PlatformMoving

var platforms: Array = []
var spawn_y: float = 0.0
var cam_y: float = 0.0

const MIN_X := -144.0
const MAX_X := 144.0       
const GAP_MIN := 80.0
const GAP_MAX := 100.0

@onready var bg1: Sprite2D = $"skybackground(1)"

@onready var bg2: Sprite2D = $"skybackground(2)"

var bg_height: float


func _ready() -> void:
	gui.show()
	platforms.append(platform_still)
	platforms.append(platform_moving)
	
	
	
	spawn_y = min(platform_still.global_position.y, platform_moving.global_position.y)
	bg_height = bg1.texture.get_height() * bg1.scale.y
	
func _physics_process(_delta: float) -> void:
	
	
	cam_y = camera.global_position.y
	
	
	while spawn_y > cam_y - 400.0:
		spawn_platform()
		
		
		
	if bg1.global_position.y > cam_y + bg_height:
		bg1.global_position.y = bg2.global_position.y - bg_height
		
		
	if bg2.global_position.y > cam_y + bg_height:
		bg2.global_position.y = bg1.global_position.y - bg_height
		
func spawn_fish_on_platform(platform: Node2D) -> void:
	if !is_instance_valid(fishes):
		return
		
	var fish := fishes.duplicate()
	
	fish.visible = true
	fish.set_process_mode(Node.PROCESS_MODE_INHERIT)
	fish.monitorable = true
	fish.monitoring = true
	
	# Spawn slightly above platform
	fish.global_position = platform.global_position + Vector2(0, -24)
	
	add_child(fish)

func spawn_platform() -> void:
	var gap := randf_range(GAP_MIN, GAP_MAX)
	spawn_y -= gap
	
	var p: Node2D
	var min_x := MIN_X
	var max_x := MAX_X
	
	if randf() < 0.5:
		p = platform_still.duplicate()
	else:
		p = platform_moving.duplicate()
		min_x = -64.0
		max_x = 64.0
		
	var x := randf_range(min_x, max_x)
	p.global_position = Vector2(x, spawn_y)
	
	add_child(p)
	platforms.append(p)
	
	
	
	
	
	if randf() < 0.3:
		spawn_fish_on_platform(p)
