tool 
extends Area2D

export var next_scene: PackedScene

func _on_EndArea_body_entered(body: Node) -> void:
	print(body.name)
	if(body.name == "jugador"):
		changeToEnd()
	
func _get_configuration_warning() -> String:
	return "La escena final ha d'estar linkada correctament" if not next_scene else ""

func changeToEnd() -> void:
	get_tree().change_scene("res://src/Screens/EndScreen.tscn")


