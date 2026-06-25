extends Node

func _ready() -> void:
	var photo = FileData.new()
	photo.file_type = FileData.FileType.PHOTO
	photo.file_name = "bunny.png"
	photo.icon = preload("res://assets/icons/bunny.png")
	photo.photo_content = preload("res://assets/icons/bunny.png")
	
	var text = FileData.new()
	text.file_type = FileData.FileType.TEXT
	text.file_name = "grocerylist.txt"
	text.icon = preload("res://assets/icons/bunny.png")
	text.text_content = "i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her. i hate her."
	
	var folder = FileData.new()
	folder.file_type = FileData.FileType.FOLDER
	folder.file_name = "trash"
	folder.icon = preload("res://assets/icons/trash.png")
	folder.folder_contents = [photo, text] as Array[FileData]  # nested test
	
	$FolderWindow.files = [photo, text, folder] as Array[FileData]
