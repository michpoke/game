extends CanvasLayer

@onready var menu_button: Button = $visible_space/menubuttoncontainer/menu
@onready var menu_panel: Panel = $visible_space/Panel
@onready var menu_container: VBoxContainer = $visible_space/Panel/menucontainer
@onready var save_button: Button = $visible_space/Panel/menucontainer/save
@onready var load_button: Button = $visible_space/Panel/menucontainer/load
@onready var quit_button: Button = $visible_space/Panel/menucontainer/quit

@onready var blue = get_tree().get_first_node_in_group("blue")

func _ready() -> void:
	
	menu_panel.hide()
	menu_button.show()

	_connect_hover(save_button)
	_connect_hover(load_button)
	_connect_hover(quit_button)
	_connect_hover(menu_button)
	
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _input(event: InputEvent) -> void:
	if not menu_panel.visible:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# check if click was outside the panel
		print("mouse clicked outside of buttons")
		if not menu_container.get_global_rect().has_point(event.position):
			menu_panel.hide()
			menu_button.show()
			Dialogic.Inputs.resume()
			print("inputs resumed")
			get_viewport().set_input_as_handled()
		
func _connect_hover(button: Button) -> void:
	button.material = button.material.duplicate()
	button.mouse_entered.connect(func(): _set_invert(button, true))
	button.mouse_exited.connect(func(): _set_invert(button, false))

func _set_invert(button: Button, inverted: bool) -> void:
	var mat = button.material as ShaderMaterial
	mat.set_shader_parameter("light_color", Color.WHITE if inverted else Color.GHOST_WHITE)
	#mat.set_shader_parameter("dark_color", Color.WHITE if inverted else Color.BLACK)

func _on_save_pressed() -> void:
	get_viewport().set_input_as_handled()
	Dialogic.Save.save("slot1")
	save_button.text = "saved."
	await get_tree().create_timer(0.8).timeout
	save_button.text = "save"
	menu_panel.hide()
	menu_button.show()
	Dialogic.Inputs.resume()

func _on_load_pressed() -> void:
	get_viewport().set_input_as_handled()
	Dialogic.Save.load("slot1")
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	# restore blue's portrait by checking what dialogic restored
	#var blue = preload("res://characters/blue.dch")
	#var blue_node = get_tree().get_first_node_in_group("blue_portrait")
	#if blue_node:
		#var portrait_name = Dialogic.Portraits.get_character_portrait(blue)
		#print("restoring blue portrait: ", portrait_name)
		#if blue_node.blue_portraits.has(portrait_name):
			#blue_node.texture = blue_node.blue_portraits[portrait_name]
	
	var textbox = get_tree().get_first_node_in_group("custom_textbox")
	if textbox and textbox.has_method("_update_box_style"):
		textbox._update_box_style()
	
	menu_panel.hide()
	menu_button.show()
	Dialogic.Inputs.resume()
	
func _on_quit_pressed() -> void:
	get_viewport().set_input_as_handled()
	menu_panel.hide()
	menu_button.show()
	Dialogic.Inputs.resume()
	print("quit button pressed!")

func _on_menu_button_pressed() -> void:
	get_viewport().set_input_as_handled()
	menu_panel.show()
	menu_button.hide()
	Dialogic.Inputs.pause()
	print("inputs paused")
	print("menu button pressed!")

func _on_dialogic_signal(argument: String) -> void:
	if blue and blue.has_method("_on_dialogic_signal"):
		if blue.blue_portraits.has(argument):
			blue.texture = blue.blue_portraits[argument]


func _on_load_mouse_entered() -> void:
	pass # Replace with function body.


func _on_load_mouse_exited() -> void:
	pass # Replace with function body.
