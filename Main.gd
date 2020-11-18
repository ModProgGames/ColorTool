tool
extends Control

var browser = OS.get_name() == "HTML"

enum Colors { White, Bright, Dark, Black, Custom }

enum {
	NewProject,
	Save,
	Open,
	Download,
	Upload,
	ExportTexture,
	ExportAll,
	ExportLayer,
	NewTexture
}

var backgroundColors = [
	{"name": "White", "color": Color(1, 1, 1), "id": Colors.White},
	{"name": "Bright", "color": Color(0.7, 0.7, 0.7), "id": Colors.Bright},
	{"name": "Dark", "color": Color(0.3, 0.3, 0.3), "id": Colors.Dark},
	{"name": "Black", "color": Color(0, 0, 0), "id": Colors.Black}
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	theme = UI.theme
	# Setup Background
	$Base.add_stylebox_override("panel", theme.get_stylebox("Background", "EditorStyles"))

	# Setup Menubar
	# Project
	var menu: PopupMenu = $VBoxContainer/HBoxContainer/Project.get_popup()
	menu.clear()
	menu.connect("id_pressed", self, "handle_menu")

	item(menu, "New Project", NewProject, "project_new")
	item(menu, "Save Project", Save, "project_save")
	item(menu, "Open Project", Open, "project_open")

	if browser:
		menu.add_separator()
		item(menu, "Download Project", Download, "project_download")
		item(menu, "Upload Project", Upload, "project_upload")

	menu.add_separator()
	item(menu, "Export Project (.zip)", ExportAll, "project_export_all")
	item(menu, "Export Texture (.png)", ExportTexture, "project_export_texture")
	item(menu, "Export Layer (.png)", ExportLayer)

	# Texture
	menu = $VBoxContainer/HBoxContainer/Texture.get_popup()
	menu.clear()
	menu.connect("id_pressed", self, "handle_menu")

	item(menu, "New Texture", NewTexture, "texture_new")

	# Layer
	menu = $VBoxContainer/HBoxContainer/Layer.get_popup()
	menu.clear()
	menu.connect("id_pressed", self, "handle_menu")

	# Setup EditorVBox
	$VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer.add_constant_override(
		"separation", 0
	)

	# Setup Addbutton
	var addbutton = $VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer/HBoxContainer/AddTexture
	addbutton.icon = theme.get_icon("Add", "EditorIcons")
	addbutton.add_color_override("icon_color_normal", Color(0.6, 0.6, 0.6, 0.8))

	# Setup Tabs
	var tabs = $VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer/HBoxContainer/Tabs
	tabs.add_stylebox_override("tab_fg", theme.get_stylebox("SceneTabFG", "EditorStyles"))
	tabs.add_stylebox_override("tab_bg", theme.get_stylebox("SceneTabBG", "EditorStyles"))

	# Setup Editor
	$VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer/Editor.add_stylebox_override(
		"panel", theme.get_stylebox("Content", "EditorStyles")
	)

	$VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer/Editor/VBoxContainer/Toolbar/ChangeBackground.icon = theme.get_icon(
		"CanvasLayer", "EditorIcons"
	)

	$VBoxContainer/MarginContainer/HSplitContainer/VBoxContainer/Editor/VBoxContainer/Background.color = (theme.get_color(
		"contrast_color_2", "Editor"
	))



func handle_menu(id):
	match id:
		NewProject:
			print("New Project")
		Save:
			if browser:
				printerr("Wrong File Dialog")
			$SaveDialog.popup_centered(OS.get_window_safe_area().size - Vector2(64, 128))
		Open:
			if browser:
				printerr("Wrong File Dialog")
			$OpenDialog.popup_centered(OS.get_window_safe_area().size - Vector2(64, 128))


func item(menu: PopupMenu, label: String, id: int = -1, shortcut: String = ""):
	var index = menu.get_item_count()
	menu.add_item(label, id)
	var actions = InputMap.get_action_list(shortcut)
	if actions.size() > 0:
		var sc = ShortCut.new()
		sc.shortcut = actions[0]
		menu.set_item_shortcut(index, sc)

func clearMenu(menu: PopupMenu):
	for item in menu.items:
		menu.remove_item(item)
