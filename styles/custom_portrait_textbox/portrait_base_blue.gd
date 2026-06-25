extends TextureRect
const BLUE = preload("res://characters/blue.dch")

var blue_bases = {
	"base_neutral": preload("res://assets/portraits/blue/base/base_neutral.png"),
	"base_hands_on_hips": preload("res://assets/portraits/blue/base/base_hands_on_hips.png"),
	"base_crossarm": preload("res://assets/portraits/blue/base/base_crossarm.png"),
	
	"base_special_horny_smirk": preload("res://assets/portraits/blue/base/special/base_special_horny_smirk.png"),
	"base_special_horny_thinking": preload("res://assets/portraits/blue/base/special/base_special_horny_thinking.png"),
	"base_special_horny_smoking1": preload("res://assets/portraits/blue/base/special/base_special_horny_smoking1.png"),
	"base_special_horny_smoking2": preload("res://assets/portraits/blue/base/special/base_special_horny_smoking2.png"),
	"base_special_horny_smoking3": preload("res://assets/portraits/blue/base/special/base_special_horny_smoking3.png"),\
	"base_special_goofyass": preload("res://assets/portraits/blue/base/special/base_special_goofyass.png"),
	
	"base_special_nothing": preload("res://assets/transparent_pixel.png"),
}

var default_texture: Texture2D

func _ready() -> void:
	default_texture = texture
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	Dialogic.VAR.variable_changed.connect(_on_var_changed)
	
	if Dialogic.Portraits.is_character_joined(BLUE):
		var info := Dialogic.Portraits.get_character_info(BLUE)
		var current_portrait: String = info.get("portrait", "") if info.get("node", null) else ""
		_apply_portrait(current_portrait)
#
func _on_var_changed(info: Dictionary) -> void:
	if info.get("variable") == "blue_base":
		var base = Dialogic.VAR.get_variable("blue_base")
		if base != null and base != "":
				if blue_bases[base]:
					texture = blue_bases[base]
					self.show()
					
func _apply_portrait(portrait_name: String) -> void:
	if portrait_name.begins_with("base_"):
		texture = blue_bases.get(portrait_name, default_texture)
		self.show()
	else:
		texture = default_texture

func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != BLUE:
		return
	_apply_portrait(info.get("portrait", ""))
