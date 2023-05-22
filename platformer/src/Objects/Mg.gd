extends Area2D

##Ens permet Agafar el valor d'un node i guardar-lo a una variable 
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var lives: = 1

func _on_body_entered(body: Node) -> void:
		PlayerData.lives += lives
		visible = false
		##anim_player.play("fade_out")
