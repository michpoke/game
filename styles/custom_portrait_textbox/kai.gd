extends TextureRect
const KAI = preload("res://characters/kai.dch")

var kai_expressions = {
	"angry": preload("res://assets/portraits/kai/cropped_angry.png"),
	"confident_evil": preload("res://assets/portraits/kai/cropped_confident_evil.png"),
	"silly_confused": preload("res://assets/portraits/kai/cropped_silly_confused.png"),
	"confused": preload("res://assets/portraits/kai/cropped_confused.png"),
	"embarrassed_blush": preload("res://assets/portraits/kai/cropped_embarrassed-blush.png"),
	"embarrassed": preload("res://assets/portraits/kai/cropped_embarrassed.png"),
	"exhasperated": preload("res://assets/portraits/kai/cropped_exhasperated.png"),
	"happy_blush": preload("res://assets/portraits/kai/cropped_happy-blush.png"),
	"happy": preload("res://assets/portraits/kai/cropped_happy.png"),
	"neutral": preload("res://assets/portraits/kai/cropped_neutral.png"),
	"relaxed": preload("res://assets/portraits/kai/cropped_relaxed.png"),
	"sad_guilty": preload("res://assets/portraits/kai/cropped_sad_guilty.png"),
	"smug": preload("res://assets/portraits/kai/cropped_smug.png"),
	"surprised": preload("res://assets/portraits/kai/cropped_surprised.png"),
	"very_angry": preload("res://assets/portraits/kai/cropped_very-angry.png"),
	"vindictive": preload("res://assets/portraits/kai/cropped_vindictive.png"),
}

var default_texture: Texture2D

func _ready() -> void:
	add_to_group("kai_portrait_panel")
	default_texture = texture
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	
	if Dialogic.Portraits.is_character_joined(KAI):
		var info := Dialogic.Portraits.get_character_info(KAI)
		var current_portrait: String = info.get("portrait", "") if info.get("node", null) else ""
		_apply_portrait(current_portrait)

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != KAI:
		return
	var portrait_name = info.get("portrait", "")
	_apply_portrait(portrait_name)

func _apply_portrait(portrait_name: String) -> void:
	if portrait_name.begins_with("base_special_"):
		hide()
		return
	else:
		texture = kai_expressions.get(portrait_name, kai_expressions["neutral"])
		show()
