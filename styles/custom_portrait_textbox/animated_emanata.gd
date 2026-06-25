extends AnimatedSprite2D
const KAI = preload("res://characters/kai.dch")

var kai_emanata_animated = {
	"woozy": preload("res://themes/emanata_animated_woozy.tres"),
}

func _ready() -> void:
	add_to_group("kai_portrait_panel")
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	Dialogic.VAR.variable_changed.connect(_on_variable_changed)
	_set_emanata()
	
	if Dialogic.Portraits.is_character_joined(KAI):
		if Dialogic.VAR.get_variable("kai_emanata_animated"):
			_set_emanata()

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != KAI:
		return
	_set_emanata()

func _on_variable_changed(info: Dictionary) -> void:
	if info.get("variable") == "kai_emanata_animated":
		_set_emanata()

func _set_emanata() -> void:
	var emanata: String = Dialogic.VAR.get_variable("kai_emanata_animated")
	if kai_emanata_animated.has(emanata):
		sprite_frames = kai_emanata_animated[emanata]
		play("default")
		visible = true
	else:
		stop()
		visible = false
