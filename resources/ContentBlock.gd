extends Resource
class_name ContentBlock

enum BlockType { TEXT, IMAGE, GIF }

@export var block_type: BlockType
@export var text: String = ""        # used if TEXT
@export var image: Texture2D         # used if IMAGE or GIF
