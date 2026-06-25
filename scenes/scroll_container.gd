extends ScrollContainer

@onready var dither_shader: ShaderMaterial = preload("res://styles/combined_ui_dither_shader.tres")

func _ready() -> void:
	var v_scrollbar: VScrollBar = get_v_scroll_bar()
	var h_scrollbar: HScrollBar = get_h_scroll_bar()

	v_scrollbar.material = dither_shader
	h_scrollbar.material = dither_shader
