extends Node
var fish = 0

@onready var fish_counter: Label = $GUI/Fish_Counter

@onready var fish_counter_2: Label = $GUI/Fish_Counter2


func _process(_delta: float) -> void:
	fish_counter.text = str(fish)
	fish_counter_2.text = str(fish)
	
