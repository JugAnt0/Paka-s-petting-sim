extends Node2D

@onready var obstacles_container = $obstacles
@onready var spike_template = $ObstacleTemplates/spikes
@onready var water_template = $ObstacleTemplates/waterthingy

@onready var panda = $Pandolfi
@onready var g1 = $Ground1
@onready var g2 = $Ground2

var scroll_speed := 75.0


func spawn_obstacle() -> void:
	# choose template safely
	var template: Area2D = spike_template if randf() < 0.5 else water_template

	# duplicate obstacle
	var obstacle := template.duplicate()
	obstacle.visible = true
	obstacle.monitoring = true
	obstacle.monitorable = true

	# spawn in front of panda
	var spawn_x = panda.global_position.x + 250
	var ground_y = 8
	obstacle.position = Vector2(spawn_x, ground_y)

	# add to container
	obstacles_container.add_child(obstacle)


func get_tilemap_width(tilemap: TileMapLayer) -> float:
	var rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size.x
	return rect.size.x * tile_size


func _ready() -> void:
	var width = get_tilemap_width(g1)
	g1.position = Vector2(0, 0)
	g2.position = Vector2(width, 0)


func _process(delta: float) -> void:


	# move ground
	g1.position.x -= scroll_speed * delta
	g2.position.x -= scroll_speed * delta

	var width = get_tilemap_width(g1)

	if g1.position.x <= -width:
		g1.position.x = g2.position.x + width

	if g2.position.x <= -width:
		g2.position.x = g1.position.x + width

	# move obstacles
	for obstacle in obstacles_container.get_children():
		obstacle.position.x -= scroll_speed * delta

		if obstacle.position.x < -300:
			obstacle.queue_free()



func _on_timer_timeout() -> void:
	spawn_obstacle()

func _on_speed_timer_timeout():
	scroll_speed += 2   
