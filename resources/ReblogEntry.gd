# reblog_entry.gd
extends Resource
class_name ReblogEntry

@export var username: String
@export var avatar: Texture2D
@export var comment: String = ""  # empty = plain reblog, no added commentary
@export var depth: int = 0  # for indent level

@export var post_id: String
@export var timestamp: String
@export var body: String = ""
@export var image: Texture2D
@export var quote_text: String = ""
@export var quote_source: String = ""
@export var tags: Array[String] = []
@export var notes_count: int = 0
