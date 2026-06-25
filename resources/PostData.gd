extends Resource
class_name PostData

enum PostType { TEXT, PHOTO, QUOTE, ASK }

@export var post_type: PostType
@export var post_id: String
@export var timestamp: String
@export var username: String
@export var avatar: Texture2D
@export var title: String = ""
@export var body: String = ""
@export var image: Texture2D
@export var caption: String = ""
@export var quote_text: String = ""
@export var quote_source: String = ""
@export var tags: Array[String] = []
@export var notes_count: int = 0

@export var content_blocks: Array[ContentBlock] = []   # the body, as a sequence
@export var reblog_trail: Array[ReblogEntry] = []
