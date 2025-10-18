@icon("res://server-connection(2).svg")
class_name terminal extends MeshInstance3D

@onready var area_3d: Area3D = $Area3D
@onready var icon_prompt: Label3D = $IconPrompt
@onready var terminal_ui: CanvasLayer = $TerminalUI
@onready var button: Button = $TerminalUI/Control2/Control/Button
@onready var line_edit: LineEdit = $TerminalUI/Control2/Control/LineEdit

var is_in_area : bool = false

var player: main_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()

	area_3d.body_entered.connect(went_up_to_terminal)
	area_3d.body_exited.connect(went_away_from_terminal)
	button.pressed.connect(submit_pressed)

func setup() -> void:
	terminal_ui.hide()
	icon_prompt.hide()

func went_up_to_terminal(body:main_player) -> void:
	
	player = body
	icon_prompt.show()
	is_in_area = true

func went_away_from_terminal(body:main_player) -> void:
	is_in_area = false 
	icon_prompt.hide()
	terminal_ui.hide()
	
func submit_pressed() -> void:
	
	line_edit.text = ""
	terminal_ui.visible = false
	player.player_paused = false
	
	
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("INTERACT") and is_in_area:
		terminal_ui.show()
		print(player)
		player.player_paused = true
