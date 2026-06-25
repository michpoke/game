extends Resource
class_name FileData

enum FileType { PHOTO, TEXT, FOLDER }

@export var file_type: FileType
@export var file_name: String = "untitled"
@export var icon: Texture2D           # icon shown in the fold view
@export var photo_content: Texture2D  # used if PHOTO
@export var text_content: String = "" # used if TEXT
@export var folder_contents: Array[FileData] = []  # used if FOLDER
