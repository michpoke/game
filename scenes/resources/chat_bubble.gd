extends Control
@onready var label: RichTextLabel = $NinePatchRect/MarginContainer/RichTextLabel
@onready var nine_patch = $NinePatchRect
@onready var container = $NinePatchRect/MarginContainer
var character: String
var kai_bubble_1 = preload("res://assets/text/message_box_1_kai_small.png")
var kai_bubble_2 = preload("res://assets/text/message_box_2_kai_small.png")
var blue_bubble_1 = preload("res://assets/text/message_box_1_smaller.png")
var blue_bubble_2 = preload("res://assets/text/message_box_2_smaller.png")
const PADDING_X = 20.0
const PADDING_Y = 25.0

func setup(text: String, character: String, max_width: float = 280.0) -> void:
	label.bbcode_enabled = true
	label.scroll_active = false
	label.autowrap_mode = TextServer.AUTOWRAP_WORD

	var align_tag = "left" if character else "right"
	label.text = text

	self.character = character

	if character.begins_with("kai"):
		label.add_theme_color_override("default_color", Color.WHITE)
		nine_patch.texture = [kai_bubble_1, kai_bubble_2].pick_random()
	else:
		label.add_theme_color_override("default_color", Color.BLACK)
		nine_patch.texture = [blue_bubble_1, blue_bubble_2].pick_random()

	var inner_width = max_width - PADDING_X * 2
	label.custom_minimum_size.x = inner_width
	label.size.x = inner_width

	call_deferred("_resize_to_content", max_width)

func _resize_to_content(max_width: float) -> void:
	var font = label.get_theme_font("normal_font")
	var font_size = label.get_theme_font_size("normal_font_size")
	var inner_width = max_width - PADDING_X * 2

	# use parsed text (tags stripped) so measurement matches what's rendered
	var plain_text = label.get_parsed_text()

	var measured = font.get_multiline_string_size(
		plain_text,
		HORIZONTAL_ALIGNMENT_LEFT,
		inner_width,
		font_size
	)

	var text_height = measured.y
	var text_width = min(measured.x, inner_width)

	var bubble_width = text_width + PADDING_X * 2
	var bubble_height = text_height + PADDING_Y * 2

	nine_patch.custom_minimum_size = Vector2(bubble_width, bubble_height)
	nine_patch.size = Vector2(bubble_width, bubble_height)

	label.custom_minimum_size = Vector2(text_width, 0)
	custom_minimum_size = Vector2(bubble_width, bubble_height)
	size = Vector2(bubble_width, bubble_height)
