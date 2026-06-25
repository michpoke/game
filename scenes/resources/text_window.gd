extends Control

@onready var text = $background/MarginContainer/ScrollContainer/VBoxContainer/RichTextLabel

@onready var vbox = $background/MarginContainer/ScrollContainer/VBoxContainer
@onready var scroll = $background/MarginContainer/ScrollContainer

@onready var close_button = $background/closebuttoncontainer/closebutton
#@onready var open_button = $chat_window_open_button
@onready var chat_window = $background

@onready var hint_arrow_bottom: TextureRect = $background/MarginContainer/ArrowContainerDown/ScrollHintArrow
@onready var hint_arrow_top: TextureRect = $background/MarginContainer/ArrowContainerUp/ScrollHintArrow

var bounce_tween_bottom: Tween
var bounce_tween_top: Tween

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

func _ready() -> void:

	_start_bounce()
	_save_current_layout()
	await get_tree().process_frame

func _process(_delta: float) -> void:
	var vbar = scroll.get_v_scroll_bar()
	var can_scroll_down = vbar.max_value > vbar.page and vbar.value < vbar.max_value - vbar.page - 1.0
	var can_scroll_up = vbar.max_value > vbar.page and vbar.value > 1.0

	hint_arrow_bottom.visible = can_scroll_down
	hint_arrow_top.visible = can_scroll_up

## minimize shit

func _save_current_layout() -> void:
	saved_anchor_left = chat_window.anchor_left
	saved_anchor_top = chat_window.anchor_top
	saved_anchor_right = chat_window.anchor_right
	saved_anchor_bottom = chat_window.anchor_bottom
	saved_offset_left = chat_window.offset_left
	saved_offset_top = chat_window.offset_top
	saved_offset_right = chat_window.offset_right
	saved_offset_bottom = chat_window.offset_bottom
	
	
func _on_fullscreenbutton_pressed() -> void:
	is_fullscreen = !is_fullscreen

	if is_fullscreen:
		chat_window.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	else:
		chat_window.anchor_left = saved_anchor_left
		chat_window.anchor_top = saved_anchor_top
		chat_window.anchor_right = saved_anchor_right
		chat_window.anchor_bottom = saved_anchor_bottom
		chat_window.offset_left = saved_offset_left
		chat_window.offset_top = saved_offset_top
		chat_window.offset_right = saved_offset_right
		chat_window.offset_bottom = saved_offset_bottom		
		
###
func _start_bounce() -> void:
	bounce_tween_bottom = create_tween().set_loops()
	var start_pos = hint_arrow_bottom.position.y
	bounce_tween_bottom.tween_property(hint_arrow_bottom, "position:y", start_pos + 8, 0.25).set_trans(Tween.TRANS_LINEAR)
	bounce_tween_bottom.tween_property(hint_arrow_bottom, "position:y", start_pos, 0.25).set_trans(Tween.TRANS_LINEAR)

	bounce_tween_top = create_tween().set_loops()
	var start_pos_top = hint_arrow_top.position.y
	bounce_tween_top.tween_property(hint_arrow_top, "position:y", start_pos_top - 8, 0.25).set_trans(Tween.TRANS_LINEAR)
	bounce_tween_top.tween_property(hint_arrow_top, "position:y", start_pos_top, 0.25).set_trans(Tween.TRANS_LINEAR)
	
func _on_closebutton_pressed() -> void:
	print("closed button pressed!")
	#close_button.visible = false
	#chat_window.visible = false
	queue_free()

func setup(file: FileData) -> void:
	text.text = file.text_content
