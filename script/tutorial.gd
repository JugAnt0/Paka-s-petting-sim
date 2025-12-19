extends Node2D
@onready var cam: Camera2D = $Camera2D
@onready var timer: Timer = $fade_transition/FadeTimer
@onready var arrow: TextureButton = $CanvasLayer/Arrow
@onready var i: TextureButton = $"/root/Info/i"
@onready var go_back_: TextureButton = $GO_BACK/TextureButton

func _process(_delta: float) -> void:
	if cam.limit_left == -316 and cam.limit_right == 335:
		arrow.hide()
	else:
		arrow.show()

func _ready() -> void:
	i.hide()

func _on_pakas_pressed() -> void:
	cam.limit_left = 986
	cam.limit_right = 1637



func _on_fish_pressed() -> void:
	cam.limit_left = 1637
	cam.limit_right = 2288


func _on_houses_pressed() -> void:
	cam.limit_left = 2288
	cam.limit_right = 2939


func _on_cats_pressed() -> void:
	cam.limit_left = 2939
	cam.limit_right = 3590


func _on_panda_pressed() -> void:
	cam.limit_left = 3590
	
	cam.limit_right = 4241


func _on_bellist_pressed() -> void:
	cam.limit_left = 4241
	cam.limit_right = 4892
	



func _on_flora_pressed() -> void:
	cam.limit_left = 4892
	cam.limit_right = 5543


func _on_shany_pressed() -> void:
	cam.limit_left = 5543
	cam.limit_right = 6194




func _on_arrow_pressed() -> void:
	cam.limit_left = -316
	cam.limit_right = 335


func _on_texture_button_pressed() -> void:
	i.show()
