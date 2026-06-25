# text_post.gd
extends Control
#
#signal clicked(post: PostData)
#
#@onready var title_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Label
#@onready var timestamp_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Label2
#@onready var body_label: RichTextLabel = $MarginContainer/VBoxContainer/RichTextLabel
#@onready var tags_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Label
#@onready var notes_button: Button = $MarginContainer/VBoxContainer/Button
#
#var post_data: PostData
#
#func setup(data: PostData) -> void:
	#post_data = data
	#title_label.visible = data.title != ""
	#title_label.text = data.title
	#timestamp_label.text = data.timestamp
	#body_label.text = data.body
	#tags_label.text = " ".join(data.tags.map(func(t): return "#" + t))
	#notes_button.text = "%d notes" % data.notes_count
	#notes_button.pressed.connect(func(): clicked.emit(post_data))
