extends "res://src/Actors/Actor.gd"

## funció que revisa on tots els nodes estiguin preparats al cridar o refrescar l'escena
func _ready() -> void:
	
	set_physics_process_internal(false) #desactiven la simulació del enemic si no esta en pantalla
	_vel.x = -acceleracio.x
## Signal per saber si el jugador ha xafat a l'enemic i l'elimina
func _on_xafatDetector_body_entered(body: Node) -> void:
	var physics_body: = body as PhysicsBody2D
	if physics_body.global_position.y < get_node("xafatDetector").global_position.y:
		get_node("CollisionShape2D").set_deferred("disabled", true)
		queue_free()


func _physics_process(delta: float) -> void:
	_vel.y += gravetat * delta
	if is_on_wall():
		_vel.x *= -1.0
	_vel.y = move_and_slide(_vel, FLOOR_NORMAL).y


