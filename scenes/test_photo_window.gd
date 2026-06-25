## test_photo_window.gd
#extends Node
#
#func _ready() -> void:
	#var test_file = FileData.new()
	#test_file.file_type = FileData.FileType.PHOTO
	#test_file.file_name = "test.png"
	#test_file.photo_content = preload("res://assets/icons/bunny.png")
	#$PhotoWindow.setup(test_file)

# 
extends Node

func _ready() -> void:
	var photo = FileData.new()
	photo.file_type = FileData.FileType.PHOTO
	photo.file_name = "vacation.png"
	photo.icon = preload("res://assets/icons/bunny.png")
	photo.photo_content = preload("res://assets/icons/bunny.png")
	
	var text = FileData.new()
	text.file_type = FileData.FileType.TEXT
	text.file_name = "notes.txt"
	text.icon = preload("res://assets/icons/bunny.png")
	text.text_content = "this is a test file's contents"
	
	var folder = FileData.new()
	folder.file_type = FileData.FileType.FOLDER
	folder.file_name = "trash"
	folder.icon = preload("res://assets/icons/folder_75px.png")
	folder.folder_contents = [photo, text]  # nested test
	
	$FolderWindow.files = [photo, text, folder]
