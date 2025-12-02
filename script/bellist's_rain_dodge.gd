extends Node2D
@onready var template = $Rain

@onready var timer = $SpawnTimer
@onready var spawner = $Spawner




func _ready():
	randomize()
	template.visible = false  
	timer.timeout.connect(_spawn_object)

func _spawn_object():
	var obj = template.duplicate()
	add_child(obj)

	obj.position = Vector2(
		randf_range(-230, 230),  
		-50
	)
