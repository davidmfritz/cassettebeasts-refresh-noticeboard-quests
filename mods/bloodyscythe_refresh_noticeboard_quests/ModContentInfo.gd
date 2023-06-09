extends ContentInfo

var setting_toggle_enabled: bool = true

const MODUTILS: Dictionary = {
	"settings": [
		{
			"property": "setting_toggle_enabled",
			"type": "toggle",
			"label": "Enabled",
		},
	],
}

func init_content() -> void:
	assert(DLC.has_mod("cat_modutils", 0))
	var modutils: ContentInfo = DLC.mods_by_id["cat_modutils"]
	modutils.callbacks.connect_scene_ready("res://menus/noticeboard/NoticeboardMenu.tscn", self, "_on_NoticeboardMenu_ready")

func _on_NoticeboardMenu_ready(scene: Control) -> void:
	if !setting_toggle_enabled:
		 return
	
	# remove default panel
	scene.get_node("BackButtonPanel").queue_free()
	
	# add new panel
	var mod_scene: Control = preload("menus/CustomFullWidthButtonPanel.tscn").instance()
	scene.add_child(mod_scene)
