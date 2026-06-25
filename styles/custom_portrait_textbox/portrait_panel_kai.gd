extends TextureRect

const KAI = preload("res://characters/kai.dch")

var kai_portraits = {
	"angry": preload("res://assets/portraits/kai/angry.png"),
	"annoyed": preload("res://assets/portraits/kai/annoyed.png"),
	"confused": preload("res://assets/portraits/kai/confused.png"),
	"default": preload("res://assets/portraits/kai/default.png"),
	"happy": preload("res://assets/portraits/kai/happy.png"),
	"slight_smile": preload("res://assets/portraits/kai/slight_smile.png"),
	"smug": preload("res://assets/portraits/kai/smug.png"),
	"surprised": preload("res://assets/portraits/kai/surprised.png"),
}

func _ready() -> void:
	add_to_group("kai_portrait_panel")
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != KAI:
		return
	var portrait_name = info.get("portrait", "default")
	if kai_portraits.has(portrait_name):
		texture = kai_portraits[portrait_name]
