extends Sprite

var direction = false

func init(d):
	direction = d
func _physics_process(delta: float) -> void:
	if direction:
		position.x -= 18
	else:
		position.x +=18

## esborrem els progectils si surten de la càmera (viewport)
func _on_viewport_exited(viewport: Viewport) -> void:
	queue_free()

##Si les bales toquen els murs es destrueixen
func _on_Area2D_body_entered(body: Node) -> void:
	if body is TileMap: queue_free()
	if body.name == "jugador":
		body.die()
