extends Node2D
@onready var fishes: Area2D = $fish
@onready var obstacles_container = $obstacles
@onready var spike_template = $ObstacleTemplates/spikes
@onready var water_template = $ObstacleTemplates/waterthingy
@onready var gui: CanvasLayer = $"/root/FishManager/GUI"
@onready var back1: Parallax2D = $background1/back
@onready var front1: Parallax2D = $background1/front
@onready var mid1: Parallax2D = $background1/mid
@onready var mid2: Parallax2D = $background2/mid
@onready var front2: Parallax2D = $background2/front
@onready var back2: Parallax2D = $background2/back

var bg_width = 256
 


@onready var panda = $Pandolfi
@onready var g1 = $Ground1
@onready var g2 = $Ground2

var scroll_speed := 75.0


func spawn_obstacle() -> void:
	var template: Area2D = spike_template if randf() < 0.5 else water_template
	
	var obstacle := template.duplicate()
	obstacle.visible = true
	obstacle.monitoring = true
	obstacle.monitorable = true
	
	var spawn_x = panda.global_position.x + 250
	var ground_y = 8
	obstacle.position = Vector2(spawn_x, ground_y)
	
	obstacles_container.add_child(obstacle)
	
	
	
func get_tilemap_width(tilemap: TileMapLayer) -> float:
	var rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size.x
	return rect.size.x * tile_size
	
		
func _ready() -> void:
	var width = get_tilemap_width(g1)
	g1.position = Vector2(0, 0)
	g2.position = Vector2(width, 0)
	gui.show()
	
func _process(delta: float) -> void:
	
	var back_speed := scroll_speed * 0.1
	var mid_speed := scroll_speed * 0.5
	var front_speed := scroll_speed * 0.8
	
	back1.scroll_offset.x -= back_speed * delta
	mid1.scroll_offset.x -= mid_speed * delta
	mid2.scroll_offset.x -= mid_speed * delta
	
	back2.scroll_offset.x -= back_speed * delta
	front1.scroll_offset.x -= front_speed * delta
	front2.scroll_offset.x -= front_speed * delta
	
	if back1.scroll_offset.x <= -bg_width:
		back1.scroll_offset.x = back2.scroll_offset.x + bg_width
	if back2.scroll_offset.x <= -bg_width:
		back2.scroll_offset.x = back1.scroll_offset.x + bg_width
		
	if mid1.scroll_offset.x <= -bg_width:
		mid1.scroll_offset.x = mid2.scroll_offset.x + bg_width
	if mid2.scroll_offset.x <= -bg_width:
		mid2.scroll_offset.x = mid1.scroll_offset.x + bg_width
		
	if front1.scroll_offset.x <= -bg_width:
		front1.scroll_offset.x += bg_width * 2
	if front2.scroll_offset.x <= -bg_width:
		front2.scroll_offset.x += bg_width * 2
		
		
		
	g1.position.x -= scroll_speed * delta
	g2.position.x -= scroll_speed * delta
		
	var width = get_tilemap_width(g1)
		
		
	if g1.position.x <= -width:
		g1.position.x = g2.position.x + width
	if g2.position.x <= -width:
		g2.position.x = g1.position.x + width
		
	for obstacle in obstacles_container.get_children():
		obstacle.position.x -= scroll_speed * delta
		
		if obstacle.position.x < -300:
			obstacle.queue_free()
			
func spawn_fish() -> void:
	if !is_instance_valid(fishes):
		return
		
	var fish := fishes.duplicate()
	
	fish.visible = true
	fish.set_physics_process(false)
	fish.set_process(false)
	fish.set_process_mode(Node.PROCESS_MODE_INHERIT)
	
	var spawn_x : float = panda.global_position.x +250
	var spawn_y := randf_range(0, 9) 
	
	fish.position = Vector2(spawn_x, spawn_y)
	
	obstacles_container.add_child(fish)
	
			
func _on_timer_timeout() -> void:
	spawn_obstacle()
	
	if randf() < 0.3:
		spawn_fish()
		
func _on_speed_timer_timeout() -> void:
	scroll_speed += 2
