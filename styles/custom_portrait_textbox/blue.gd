extends TextureRect

const BLUE = preload("res://characters/blue.dch")

var base_blue_portraits = {
	"neutral": preload("res://assets/portraits/blue/base/base_neutral.png"),
	"crossarm": preload("res://assets/portraits/blue/base/base_crossarm.png"),
	"hands_on_hips": preload("res://assets/portraits/blue/base/base_hands_on_hips.png"),
}

func _ready() -> void:
	add_to_group("blue_portrait")
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != BLUE:
		return
	var portrait_name = info.get("portrait", "neutral")
	if base_blue_portraits.has(portrait_name):
		texture = blue_portraits[portrait_name]
