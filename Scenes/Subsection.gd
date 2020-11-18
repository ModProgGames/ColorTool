extends VBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var box = StyleBoxFlat.new()
	box.bg_color = UI.theme.get_color("prop_section","Editor")
	add_stylebox_override("panel", box)
	var arrow = $Header/CenterContainer/HBoxContainer/Arrow
	arrow.texture = UI.theme.get_icon("arrow","Tree")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
