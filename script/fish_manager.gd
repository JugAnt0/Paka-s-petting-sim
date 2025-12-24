extends Node
var fish = 0
@onready var fish_counter: Label = $"/root/FishManager/GUI/Fish_Counter"
@onready var sprite: Sprite2D = $"/root/FishManager/GUI/Sprite2D"

@onready var fish_counter_2: Label = $"/root/FishManager/GUI/Fish_Counter2"

var houses = {
	"red": true,
	"blue": false,
	"yellow": false }

var house_prices = {
	"blue": 10,
	"yellow": 50 }


func _process(_delta: float) -> void:
	fish_counter.text = str(fish)
	fish_counter_2.text = str(fish)
	
func buy_house(color: String) -> bool:
	if houses[color]:
		return false  # already unlocked
	var price = house_prices[color]
	if fish >= price:
		fish -= price
		houses[color] = true
		return true
	return false
