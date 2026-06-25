extends TextureRect


@onready var scroll_container: ScrollContainer = $ScrollContainer

func _process(_delta: float) -> void:
	var vbar = scroll_container.get_v_scroll_bar()
	# show hint only if there's more to scroll
	self.visible = vbar.max_value > vbar.page and vbar.value < vbar.max_value - vbar.page - 1.0
