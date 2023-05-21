extends "res://src/Actors/Actor.gd"

export var score: = 100
onready var bullet = preload("res://src/Objects/Bullet.tscn")
var b 
## funció que revisa on tots els nodes estiguin preparats al cridar o refrescar l'escena
func _ready() -> void:
	set_physics_process_internal(false) #desactiven la simulació del enemic si no esta en pantalla
	_vel.x = -acceleracio.x
## Signal per saber si el jugador ha xafat a l'enemic i l'elimina
func _on_xafatDetector_body_entered(body: Node) -> void:
	var physics_body: = body as PhysicsBody2D
	if physics_body.global_position.y < get_node("xafatDetector").global_position.y:
		get_node("CollisionShape2D").set_deferred("disabled", true)
		die()


func _physics_process(delta: float) -> void:
	_vel.y += gravetat * delta
	if is_on_wall():
		_vel.x *= -1.0
		
	var snap: = Vector2.DOWN * 65.0
	_vel.y = move_and_slide_with_snap(
		_vel, snap, FLOOR_NORMAL
	).y
	
	if $RayCast2D.is_colliding():
		if $Timer.is_stopped():
			$Timer.start()
	else:
		if not $Timer.is_stopped():
			$Timer.stop()
	
	if _vel.x > 0: 
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	else: 
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	

##Funcio per disparar l'arma l'hi passem per parametre la direcció 
func shoot(direction):
		b = bullet.instance()
		b.init(direction) 
		get_parent().add_child(b)
		b.global_position = $Position2D.global_position
		
##Si la bala toca l'enemic el matem
func _on_BulletHit_area_entered(area: Area2D) -> void:
	$AnimatedSprite.play("die")
	area.get_parent().queue_free()
	die()
	
func die() -> void:
	$AnimatedSprite.play("die")
	PlayerData.score +=100
	queue_free()


func _on_Timer_timeout() -> void:
	##shoot(true)
	if _vel.x > 0 :
		$Position2D.position.x = 57
		shoot(false)
	else:
		$Position2D.position.x = -57 
		shoot(true)
	
