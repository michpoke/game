@tool
extends DialogicLayoutLayer
const BOX_TEXTURES = {
	"kai_talking":  preload("res://assets/text/irl_text/kai_talking.png"),
	"kai_thinking": preload("res://assets/text/irl_text/kai_thinking.png"),
	"kai_wobbly": preload("res://assets/text/irl_text/kai_wobbly.png"),
	"kai_yelling": preload("res://assets/text/irl_text/kai_yelling.png"),
	
	"blue_talking":  preload("res://assets/text/irl_text/blue_talking.png"),
	"blue_thinking": preload("res://assets/text/irl_text/blue_thinking.png"),
	"blue_wobbly": preload("res://assets/text/irl_text/blue_wobbly.png"),
	"blue_yelling": preload("res://assets/text/irl_text/blue_yelling.png"),
}
@onready var dialog_panel: PanelContainer = $Anchor/Panel
@onready var portrait_kai: MarginContainer = $Anchor/PortraitPanel_kai
@onready var portrait_kai_background: TextureRect = $Anchor/PortraitPanel_kai/PortraitBackground
@onready var dialog_text: RichTextLabel = $Anchor/Panel/HBox/MarginContainer/VBoxContainer/DialogicNode_DialogText
@onready var name_label: Label = $Anchor/Panel/HBox/MarginContainer/VBoxContainer/DialogicNode_NameLabel
@onready var next_indicator: Control = $Anchor/Panel/HBox/MarginContainer2/DialogicNode_NextIndicator
@onready var dialog_margin_container: MarginContainer = $Anchor/Panel/HBox/MarginContainer
@onready var shader = preload("res://assets/shaders/combined_dither_and_wobble.gdshader")

var current_speaker: String = ""

func _ready() -> void:
	
	Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
	
	if Dialogic.VAR.laptop == true:
		$Anchor.visible = false
		$TextureRect.visible = false
		return
		
	else:
		add_to_group("custom_textbox")
		Dialogic.VAR.variable_changed.connect(_on_variable_changed)
		$Anchor.visible = true
		$TextureRect.visible = true
		_update_box_style()
	
	# Connect to Dialogic's variable_changed signal
func _on_variable_changed(info: Dictionary) -> void:
	if info.get("variable") == "box_mood":
		var val = Dialogic.VAR.get_variable("box_mood")
		if val != null and val != "":
			_update_box_style()
			
func _on_about_to_show_text(info: Dictionary) -> void:
	var character = info.get("character", null)
	if character == null:
		$Anchor.visible = false
		$TextureRect.visible = false
		return
	else:
		$Anchor.visible = true
		$TextureRect.visible = true
		current_speaker = character.display_name.to_lower()
		_update_box_style()  

#box switching shit
func _update_box_style() -> void:
	if current_speaker == "":
		print("no current speaker.")
		return
	
	# mood defaults to "talking" unless a box_mood variable says otherwise
	var mood: String = Dialogic.VAR.get_variable("box_mood")
	if mood == null or mood == "":
		mood = "talking"
	
	var style_name: String = current_speaker + "_" + mood
	print(style_name)
	
	if BOX_TEXTURES.has(style_name):
		var stylebox = StyleBoxTexture.new()
		stylebox.texture = BOX_TEXTURES[style_name]
		dialog_panel.add_theme_stylebox_override("panel", stylebox)
		portrait_kai_background.texture = BOX_TEXTURES[style_name]
		
		if style_name.begins_with("blue"):
			dialog_text.add_theme_color_override("default_color", Color.BLACK)
			name_label.add_theme_color_override("font_color", Color.BLACK)
			name_label.add_theme_constant_override("outline_size", 10)
			name_label.add_theme_color_override("font_outline_color", Color.WHITE_SMOKE)
			next_indicator.texture = preload("res://assets/gui/arrow_black.png")
		
		else:
			dialog_text.add_theme_color_override("default_color", Color.WHITE)
			name_label.add_theme_color_override("font_color", Color.WHITE)
			name_label.add_theme_constant_override("outline_size", 10)
			name_label.add_theme_color_override("font_outline_color", Color.BLACK)
			next_indicator.texture = preload("res://assets/gui/arrow_white.png")
			
		if style_name.ends_with("_talking") == false:
			dialog_margin_container.add_theme_constant_override("margin_left", 30)
				
		else:
			dialog_margin_container.add_theme_constant_override("margin_left", 14)
