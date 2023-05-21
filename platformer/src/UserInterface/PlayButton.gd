tool ##ens permet executar codi dins l'entorn i ens serveix per exemple per avisar d'errors
extends Button

##Boto que ens permet canviar de pantalla al joc un cop fem "release"
onready var scene_tree: = get_tree()
export(String, FILE) var next_scene_path: = ""

func _on_button_up() -> void:
	scene_tree.paused = false
	PlayerData.reset()
	get_tree().change_scene(next_scene_path)
	
func _get_configuration_warning() -> String:
	return "next_scene_path ha d'estar fixada perquè el botó funcioni" if next_scene_path == "" else ""
