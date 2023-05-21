extends Button

func _on_button_up() -> void:
	PlayerData.score = 0
	get_tree().paused = false ##variable que ens permet despausar el joc
	get_tree().reload_current_scene()
