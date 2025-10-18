extends Control

@onready var texture_button: TextureButton = $CanvasLayer/TextureButton
const LEVEL_ONE = preload("uid://byu7e6fr0eupo")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_button.pressed.connect(button_pressed)


func button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_ONE)
