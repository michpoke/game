extends TextureRect
const KAI = preload("res://characters/kai.dch")

var kai_bases = {
	"base_special_drunk": preload("res://assets/portraits/kai/base_special_drunk.png"),
}

var default_texture: Texture2D

func _ready() -> void:
	default_texture = texture
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	
	if Dialogic.Portraits.is_character_joined(KAI):
		var info := Dialogic.Portraits.get_character_info(KAI)
		var current_portrait: String = info.get("portrait", "") if info.get("node", null) else ""
		_apply_portrait(current_portrait)

func _apply_portrait(portrait_name: String) -> void:
	if portrait_name.begins_with("base_special_"):
		texture = kai_bases.get(portrait_name, default_texture)
	else:
		texture = default_texture

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != KAI:
		return
	_apply_portrait(info.get("portrait", ""))
