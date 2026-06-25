extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	Dialogic.start("res://timeline/kai_gets_drunk.dtl")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
