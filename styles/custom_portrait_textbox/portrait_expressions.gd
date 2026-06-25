extends TextureRect

const BLUE = preload("res://characters/blue.dch")

var blue_expressions = {
	"angry": preload("res://assets/portraits/blue/expressions/angry.png"),
	"confused_worried": preload("res://assets/portraits/blue/expressions/confused_worried.png"),
	"displeased": preload("res://assets/portraits/blue/expressions/displeased.png"),
	"neutral": preload("res://assets/portraits/blue/expressions/neutral.png"),
	"poker_face": preload("res://assets/portraits/blue/expressions/poker_face.png"),
	"sad_looking_away": preload("res://assets/portraits/blue/expressions/sad-looking-away.png"),
	"sad": preload("res://assets/portraits/blue/expressions/sad.png"),
	"shocked": preload("res://assets/portraits/blue/expressions/shocked.png"),
	"suggestive_mouth_closed": preload("res://assets/portraits/blue/expressions/suggestive-(mouth-closed).png"),
	"suggestive": preload("res://assets/portraits/blue/expressions/suggestive.png"),
	"very_angry": preload("res://assets/portraits/blue/expressions/very_angry.png"),
	"vindictive": preload("res://assets/portraits/blue/expressions/vindictive.png"),
}

var default_texture: Texture2D

func _ready() -> void:
	default_texture = texture
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	Dialogic.VAR.variable_changed.connect(_on_var_changed)
	
	# Re-sync immediately in case this scene was just rebuilt
	# (style change, box_style change, etc.) without a fresh signal firing.
	if Dialogic.Portraits.is_character_joined(BLUE):
		var info := Dialogic.Portraits.get_character_info(BLUE)
		var current_portrait: String = info.get("portrait", "") if info.get("node", null) else ""
		_apply_portrait(current_portrait)

func _on_var_changed(info: Dictionary) -> void:
	if info.get("variable") == "blue_base":
		var base = Dialogic.VAR.get_variable("blue_base")
		if base.begins_with("base_special_"):
			self.visible = false	
		else:
			self.visible = true
			

func _apply_portrait(portrait_name: String) -> void:
	if portrait_name.begins_with("base_special_"):
		self.visible = false
	else:
		if blue_expressions.has(portrait_name):
			texture = blue_expressions[portrait_name]
			self.visible = true

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != BLUE:
		return
	_apply_portrait(info.get("portrait", ""))
