extends Control

@onready var close_button = $closebutton
@onready var open_button = $openbutton
@onready var chat_window = $MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_openbutton_pressed() -> void:
	close_button.visible = true
	chat_window.visible = true
	print("open up")


func _on_closebutton_pressed() -> void:
	close_button.visible = false
	chat_window.visible = false
	print("should be closing...")
