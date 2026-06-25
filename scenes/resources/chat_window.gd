extends DialogicLayoutLayer

@onready var vbox = $TextureRect/MarginContainer/ScrollContainer/VBoxContainer
@onready var scroll = $TextureRect/MarginContainer/ScrollContainer

@onready var close_button = $TextureRect/closebuttoncontainer/closebutton
@onready var open_button = $chat_window_open_button
@onready var chat_window = $TextureRect

@onready var hint_arrow_bottom: TextureRect = $TextureRect/MarginContainer/ArrowContainerDown/ScrollHintArrow
@onready var hint_arrow_top: TextureRect = $TextureRect/MarginContainer/ArrowContainerUp/ScrollHintArrow

var bounce_tween_bottom: Tween
var bounce_tween_top: Tween

var bubble_scene = preload("res://scenes/resources/chat_bubble.tscn")

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
	

	# start timeline here instead of from desktop.gd
	if Dialogic.current_timeline == null:
		Dialogic.start("chat_test")
		
	add_to_group("chat_window")
	_start_bounce()
	_save_current_layout()
	await get_tree().process_frame
	
	if not Dialogic.Text.about_to_show_text.is_connected(_on_about_to_show_text):
		Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
	
	if not Dialogic.signal_event.is_connected(_on_dialogic_signal):
		Dialogic.signal_event.connect(_on_dialogic_signal)

			
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

func _on_chat_window_open_button_pressed() -> void:
	close_button.visible = true
	chat_window.visible = true
	Dialogic.paused = false
	
func _on_closebutton_pressed() -> void:
	print("closed button pressed!")
	close_button.visible = false
	chat_window.visible = false
	Dialogic.paused = true
	
func _on_about_to_show_text(info: Dictionary) -> void:
	var text = info.get("text", "")
	var character = info.get("character", null)
	if character != null:
		character = character.display_name.to_lower()
		add_message(text, character)

func _on_dialogic_signal(argument: String) -> void:
	
	var character = argument
	
	if argument == "show_typing":
		show_typing(character)
	elif argument == "hide_typing":
		hide_typing()

func add_message(text: String, character: String) -> void:
	var bubble = bubble_scene.instantiate()
		
	if character.begins_with("kai"):
		bubble.size_flags_horizontal = Control.SIZE_SHRINK_END
		
	else:
		bubble.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN

	bubble.modulate.a = 0.0
	vbox.add_child(bubble)
	
	await get_tree().process_frame
	
	var max_width = scroll.size.x / 2
	bubble.setup(text, character, max_width)
	
	await get_tree().process_frame
	await get_tree().process_frame
	vbox.queue_sort()
	bubble.modulate.a = 1.0
	scroll.scroll_vertical = scroll.get_v_scroll_bar().max_value
	
func show_typing(character: String) -> void:
	add_message("...", character)

func hide_typing() -> void:
	var last = vbox.get_child(vbox.get_child_count() - 1)
	if last:
		last.queue_free()
		
