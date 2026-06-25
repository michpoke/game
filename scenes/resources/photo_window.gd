extends Control

@onready var image: TextureRect = $background/MarginContainer/image

@onready var close_button = $background/closebuttoncontainer/closebutton
#@onready var open_button = $window_open_button
@onready var window = $background

# gross minimizing shit
var is_fullscreen: bool = false

var saved_anchor_left: float
var saved_anchor_top: float
var saved_anchor_right: float
var saved_anchor_bottom: float
var saved_offset_left: float
var saved_offset_top: float
var saved_offset_right: float
var saved_offset_bottom: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("window")
	_save_current_layout()
	await get_tree().process_frame
	
func setup(file: FileData) -> void:
	if file != null:
		image.texture = file.photo_content

## minimize shit

func _save_current_layout() -> void:
	saved_anchor_left = window.anchor_left
	saved_anchor_top = window.anchor_top
	saved_anchor_right = window.anchor_right
	saved_anchor_bottom = window.anchor_bottom
	saved_offset_left = window.offset_left
	saved_offset_top = window.offset_top
	saved_offset_right = window.offset_right
	saved_offset_bottom = window.offset_bottom
	
	
func _on_fullscreenbutton_pressed() -> void:
	is_fullscreen = !is_fullscreen
	print("fullscreen button pressed!")

	if is_fullscreen:
		window.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	else:
		window.anchor_left = saved_anchor_left
		window.anchor_top = saved_anchor_top
		window.anchor_right = saved_anchor_right
		window.anchor_bottom = saved_anchor_bottom
		window.offset_left = saved_offset_left
		window.offset_top = saved_offset_top
		window.offset_right = saved_offset_right
		window.offset_bottom = saved_offset_bottom		
	
func _on_closebutton_pressed() -> void:
	print("closed button pressed!")
	queue_free()
	
