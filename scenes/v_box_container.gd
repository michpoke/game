extends VBoxContainer


@onready var menu_button: Button = $Button

func _ready() -> void:
	menu_button.button_down.connect(_on_menu_button_down)
	menu_button.button_up.connect(_on_menu_button_up)

func _on_menu_button_down() -> void:
	menu_button.add_theme_color_override("font_color", Color.WHITE)
	menu_button.add_theme_color_override("font_outline_color", Color.BLACK)

func _on_menu_button_up() -> void:
	menu_button.add_theme_color_override("font_color", Color.BLACK)
	menu_button.add_theme_color_override("font_outline_color", Color.WHITE)
