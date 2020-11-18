tool
extends HBoxContainer

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var normal: StyleBox;
var focus: StyleBox;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normal = StyleBoxFlat.new()
	normal.bg_color = UI.theme.get_color("dark_color_2","Editor")
	focus = UI.theme.get_stylebox("focus","LineEdit")
	if focus is StyleBoxFlat:
		focus.bg_color = UI.theme.get_color("dark_color_2","Editor")
	$Panel.add_stylebox_override("panel", normal)
	$Reset.icon = UI.theme.get_icon("Reload", "EditorIcons")

	$Panel/MarginContainer/SpinBox.get_line_edit().connect("focus_entered",self,"style_focus")
	$Panel/MarginContainer/SpinBox.get_line_edit().connect("focus_exited",self,"style_normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func style_focus() -> void:
	print("hi")
	$Panel.add_stylebox_override("panel",focus)

func style_normal() -> void:
	print("hi")
	$Panel.add_stylebox_override("panel",normal)
