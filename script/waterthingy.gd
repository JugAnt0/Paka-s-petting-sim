extends Area2D
@onready var timer: Timer = $"../../DeathTimer"

@onready var pandolfi: CharacterBody2D = $"../../Pandolfi"






func _on_body_entered(body: Node2D) -> void:

	if body.name == "Pandolfi":
		body.die()
