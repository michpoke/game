extends Button

@onready var chat_window = get_parent()  # chat_window node

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	chat_window.visible = false
