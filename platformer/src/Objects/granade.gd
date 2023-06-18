extends RigidBody2D
#
onready var explosion = preload("res://src/Objects/Explosion.tscn")

var strenght = 0
var direction = false

func init(d):
	direction = d

func throw(impulse_vec):
	strenght = impulse_vec
	if (direction):
		strenght.x *= -1
		
	apply_impulse(Vector2.ZERO, strenght)


func _on_Timer_timeout() -> void:
	$Timer.stop()
	sleeping = true
	var expl = explosion.instance()
	add_child(expl)
	expl.connect("explosion_ended", self, "nade_exploded")
	$Sprite.hide()

func nade_exploded():
	queue_free()
