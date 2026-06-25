extends Control

@export var files: Array[FileData] = []
const FILE_ICON = preload("res://scenes/resources/file_icon.tscn")
@onready var grid: GridContainer = $background/MarginContainer/ScrollContainer/VBoxContainer/GridContainer

@onready var vbox = $background/MarginContainer/ScrollContainer/VBoxContainer
@onready var scroll = $background/MarginContainer/ScrollContainer

@onready var close_button = $background/closebuttoncontainer/closebutton
@onready var window = $background

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

var _is_ready: bool = false

func _ready() -> void:
	_is_ready = true
	_start_bounce()
	_save_current_layout()
	await get_tree().process_frame
	_populate_grid()


func _process(_delta: float) -> void:
	var vbar = scroll.get_v_scroll_bar()
	var can_scroll_down = vbar.max_value > vbar.page and vbar.value < vbar.max_value - vbar.page - 1.0
	var can_scroll_up = vbar.max_value > vbar.page and vbar.value > 1.0

	hint_arrow_bottom.visible = can_scroll_down
	hint_arrow_top.visible = can_scroll_up

# Called externally to turn this window into a view of a specific folder's contents.
# Safe to call before OR after this node enters the tree.
func setup(file: FileData) -> void:
	files = file.folder_contents
	if _is_ready:
		# _ready() already ran (and may have populated with an empty/old list) — refresh now
		_populate_grid()
	# if _ready() hasn't run yet, _ready() will call _populate_grid() itself once it does

func _populate_grid() -> void:
	for child in grid.get_children():
		child.queue_free()
	for file in files:
		var icon_instance = FILE_ICON.instantiate()
		grid.add_child(icon_instance)
		icon_instance.setup(file)
		icon_instance.opened.connect(_on_file_opened)

func _on_file_opened(file: FileData) -> void:
	var window_scene = _get_window_scene_for_type(file.file_type)
	var new_window = window_scene.instantiate()

	# For folders, set `files` BEFORE add_child so _ready() picks up the right contents.
	if file.file_type == FileData.FileType.FOLDER:
		new_window.files = file.folder_contents

	add_child(new_window)
	new_window.setup(file)

	# randomize position within laptop bounds, leaving margin so it doesn't clip off-screen
	await get_tree().process_frame  # let layout settle so `size` is accurate
	var desktop_size = get_viewport_rect().size
	var window_size = new_window.size
	var margin = 100
	var max_x = max(margin, desktop_size.x - window_size.x - margin)
	var max_y = max(margin, desktop_size.y - window_size.y - margin)
	new_window.set_anchors_preset(Control.PRESET_TOP_LEFT)
	new_window.position = Vector2(
		randf_range(margin, max_x),
		randf_range(margin, max_y)
	)
	
	_save_current_layout()

func _get_window_scene_for_type(type: FileData.FileType) -> PackedScene:
	match type:
		FileData.FileType.PHOTO: return preload("res://scenes/resources/photo_window.tscn")
		FileData.FileType.TEXT: return preload("res://scenes/resources/text_window.tscn")
		FileData.FileType.FOLDER: return preload("res://scenes/resources/folder_window.tscn")
	return preload("res://scenes/resources/text_window.tscn")

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

	if is_fullscreen:
		window.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	else:
		window.anchor_left = saved_anchor_left
		window.anchor_top = saved_anchor_top
		window.anchor_right = saved_anchor_right
		print(saved_anchor_right)
		window.anchor_bottom = saved_anchor_bottom
		window.offset_left = saved_offset_left
		window.offset_top = saved_offset_top
		window.offset_right = saved_offset_right
		print(saved_offset_right)
		window.offset_bottom = saved_offset_bottom

### bounce function for arrows
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
	queue_free()
