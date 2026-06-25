# post_feed.gd
extends Control

@export var posts: Array[PostData] = []
const TEXT_POST = preload("res://scenes/posts/textpost.tscn")
const PHOTO_POST = preload("res://scenes/posts/imagepost.tscn")
const ASK_POST = preload("res://scenes/posts/ask_box.tscn")

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var hint_arrow: TextureRect = $ScrollHintArrow
var bounce_tween: Tween

@onready var vbar = $ScrollContainer.get_v_scroll_bar()

func _ready() -> void:
	_start_bounce()
	for post in posts:
		var scene = _get_scene_for_type(post.post_type)
		var instance = scene.instantiate()
		instance.setup(post)
		instance.clicked.connect(_on_post_clicked.bind(post))
		$VBoxContainer.add_child(instance)
		

func _start_bounce() -> void:
	bounce_tween = create_tween().set_loops()
	var start_pos = hint_arrow.position.y
	bounce_tween.tween_property(hint_arrow, "position:y", start_pos + 8, 0.25).set_trans(Tween.TRANS_LINEAR)
	bounce_tween.tween_property(hint_arrow, "position:y", start_pos, 0.25).set_trans(Tween.TRANS_LINEAR)

func _process(_delta: float) -> void:
	var vbar = scroll_container.get_v_scroll_bar()
	hint_arrow.visible = vbar.max_value > vbar.page and vbar.value < vbar.max_value - vbar.page - 1.0
	
	
func _get_scene_for_type(type: PostData.PostType) -> PackedScene:
	match type:
		PostData.PostType.TEXT: return TEXT_POST
		PostData.PostType.PHOTO: return PHOTO_POST
		PostData.PostType.ASK: return ASK_POST
	return TEXT_POST

func _on_post_clicked(post: PostData) -> void:
	get_tree().current_scene.show_post_detail(post)
