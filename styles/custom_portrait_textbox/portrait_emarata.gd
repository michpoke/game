extends TextureRect

const BLUE = preload("res://characters/blue.dch")

var blue_emanata = {
	"emanata_none": preload("res://assets/transparent_pixel.png"),
	"emanata_blush": preload("res://assets/portraits/blue/expressions/emanata_blush.png"),
	"emanata_heavy_blush": preload("res://assets/portraits/blue/expressions/emanata_heavy_blush.png"),
	"emanata_smoke": preload("res://assets/portraits/blue/expressions/emanta_smoke.png"),
}

var emanata: String = ""  

func _ready() -> void:
	emanata = Dialogic.VAR.get_variable("blue_emanata")
	add_to_group("blue_portrait_panel")
	Dialogic.Portraits.character_portrait_changed.connect(_on_portrait_changed)
	Dialogic.Portraits.character_joined.connect(_on_portrait_changed)
	Dialogic.VAR.variable_changed.connect(_on_variable_changed)
	
func _on_portrait_changed(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character != BLUE:
		return
	_set_emanata(info)

func _on_variable_changed(info: Dictionary) -> void:
	if info.get("variable") == "blue_emanata":
		_set_emanata(info)
			
func _set_emanata(info: Dictionary) -> void:
	var emanata = Dialogic.VAR.get_variable("blue_emanata")
	if emanata != null and emanata != "":
		if emanata.begins_with("animated_"):
			texture = blue_emanata["emanata_none"]
		else: 
			texture = blue_emanata[emanata]
			#print ("setting emanata change...")
