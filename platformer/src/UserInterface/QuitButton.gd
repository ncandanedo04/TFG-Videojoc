tool ##ens permet executar codi dins l'entorn i ens serveix per exemple per avisar d'errors
extends Button

##Funcio que ens permet sortir del joc
func _on_button_up() -> void:
	get_tree().quit()
