extends Area2D


var speed := 200.0

func _ready():
	visible = true  

func _process(delta: float) -> void:
	position.y += speed * delta

	if position.y > 1000: 
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.name == "Bellist":
		print("became wet")
