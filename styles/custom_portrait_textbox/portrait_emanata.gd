extends TextureRect
const KAI = preload("res://characters/kai.dch")

var kai_emanata = {
	"none": preload("res://assets/transparent_pixel.png"),
	"blush_sweat": preload("res://assets/portraits/kai/emanata_blush_sweat.png"),
	"weary_sweat": preload("res://assets/portraits/kai/emanata_weary_sweat.png"),
}

func _ready() -> void:
	add_to_group("kai_portrait_panel")
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	Dialogic.VAR.variable_changed.connect(_on_variable_changed)
	_set_emanata()
	
	if Dialogic.Portraits.is_character_joined(KAI):
		if Dialogic.VAR.get_variable("kai_emanata"):
			_set_emanata()

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != KAI:
		return
	_set_emanata()

func _on_variable_changed(info: Dictionary) -> void:
	if info.get("variable") == "kai_emanata":
		_set_emanata()

func _set_emanata() -> void:
	var emanata: String = Dialogic.VAR.get_variable("kai_emanata")
	texture = kai_emanata.get(emanata, kai_emanata["none"])
