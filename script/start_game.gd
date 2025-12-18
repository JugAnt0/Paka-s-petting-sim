extends Node2D
@onready var gui: CanvasLayer = $"/root/FishManager/GUI"
@onready var fish_counter: Label = $"/root/FishManager/GUI/Fish_Counter"
@onready var sprite: Sprite2D = $"/root/FishManager/GUI/Sprite2D"
@onready var fish_counter_2: Label = $"/root/FishManager/GUI/Fish_Counter2"
@onready var yellow_house: TextureButton = $"Button Control/YellowButton"
@onready var blue_house: TextureButton = $"Button Control/BlueButton"
@onready var lights_yellow: Node2D = $"Button Control/YellowButton/Lights"
@onready var lights_blue: Node2D = $"Button Control/BlueButton/lights"
@onready var lockB: Sprite2D = $"Button Control/BlueButton/LockIcon"
@onready var lockY: Sprite2D = $"Button Control/YellowButton/LockIcon"

func _ready() -> void:
	sprite.position = Vector2(610, 78)
	fish_counter.position = Vector2(320, 52)
	fish_counter_2.position = Vector2(322, 54)
	$fade_transition/AnimationPlayer.play("fade_out")
	gui.show()
	update_houses()
	
	




func update_houses():
	if FishManager.houses["blue"]:
		unlock_house(blue_house)
		lights_blue.show()
	else:
		lock_house(blue_house, FishManager.house_prices["blue"])
		
	if FishManager.houses["yellow"]:
		unlock_house(yellow_house)
		lights_yellow.show()
	else:
		lock_house(yellow_house, FishManager.house_prices["yellow"])
		
func lock_house(house_node: Node, price: int):
	house_node.get_node("Silhouette").show()
	house_node.get_node("LockIcon").show()
	house_node.get_node("PriceLabel").text = str(price) 
	house_node.get_node("PriceLabel").show()
	
func unlock_house(house_node: Node):
	house_node.get_node("Silhouette").hide()
	house_node.get_node("LockIcon").hide()
	house_node.get_node("PriceLabel").hide()
	
	
var button_type = null	
	
func _on_red_button_pressed() -> void:
	print("Button Pressed")
	button_type = "red"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	
func _on_blue_button_pressed() -> void:
	if not FishManager.houses["blue"]:
		if FishManager.buy_house("blue"):
			lockB.get_node("AnimationPlayer").play("unlock")
		else:
			lockB.get_node("AnimationPlayer").play("locking")
		return
	button_type = "blue_b"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	
func _on_yellow_button_pressed() -> void:
	if not FishManager.houses["yellow"]:
		if FishManager.buy_house("yellow"):
			lockY.get_node("AnimationPlayer").play("unlock")
		else:
			lockY.get_node("AnimationPlayer").play("locking")
		return
		
	button_type = "yellow_b"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
		
func _on_go_back_pressed() -> void:
	button_type = "go_back"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	
func _on_fade_timer_timeout() -> void:
	gui.hide()
	fish_counter.position = Vector2(765, 52)
	fish_counter_2.position = Vector2(767, 54)
	sprite.position = Vector2(1048, 76)
	if button_type == "red":
		get_tree().change_scene_to_file("res://scenes/indoor_red_house.tscn")
		
	elif button_type == "blue_b":
		get_tree().change_scene_to_file("res://scenes/indoor_blue_house.tscn")
		
	elif button_type == "yellow_b":
		get_tree().change_scene_to_file("res://scenes/edificio_indoor.tscn")
		
	elif button_type == "go_back":
		get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "unlock":
		update_houses()
