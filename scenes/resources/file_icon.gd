# file_icon.gd
extends Control

signal opened(file: FileData)

@onready var icon_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/Label

var file_data: FileData

func ready() -> void:
	pass
	
func setup(file: FileData) -> void:
	file_data = file
	icon_rect.texture = file.icon
	name_label.text = file.file_name

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.double_click:
		opened.emit(file_data)
