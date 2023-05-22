extends "res://src/Actors/Actor.gd"

export var score: = 100
onready var bullet = preload("res://src/Objects/Bullet.tscn")
var b ##variable pel projectil
var isPlayer = null ## variable per saber is el rayCast esta tocant el jugador
##var collision = null ## variable per controlar si el Raycast està tocant el jugador

## funció que revisa on tots els nodes estiguin preparats al cridar o refrescar l'escena
func _ready() -> void:
	set_physics_process_internal(false) #desactiven la simulació del enemic si no esta en pantalla
	_vel.x = -acceleracio.x
## Signal per saber si el jugador ha xafat a l'enemic i l'elimina
func _on_xafatDetector_body_entered(body: Node) -> void:
	if(body.name == "jugador"):
		var physics_body: = body as PhysicsBody2D
		if physics_body.global_position.y < get_node("xafatDetector").global_position.y:
			get_node("CollisionShape2D_Body").set_deferred("disabled", true)
			die()

## moviment i accions de l'enemic
func _physics_process(delta: float) -> void:
	_vel.y += gravetat * delta
	
	##if is_on_wall() and is_on_floor():
	##	_vel.x *= -1.0
	if not $RayCast2D_floor_left.is_colliding() or not $RayCast2D_floor_right.is_colliding():
		_vel.x *= -1.0
		
	if  is_on_floor() and is_on_wall():
		_vel.x *= -1.0
	
	## Apliquem snap per tal que els tiles amb punxa l'enemic quedi enganxat a terra i no "voli" per l'inèrcia	
	var snap: = Vector2.DOWN * 65.0
	_vel.y = move_and_slide_with_snap(
		_vel, snap, FLOOR_NORMAL
	).y
	
	##if not $RayCast2D_floor_right.is_colliding(): 
	##	_vel.x *= -1.0
		
	##if not $RayCast2D_floor_left.is_colliding(): 
	##	_vel.x *= 1.0
	
	
	if $RayCast2D_left.is_colliding(): 
		var collision = $RayCast2D_left.get_collider()
		if collision.name == "jugador":
			isPlayer = true
			_vel.x = -acceleracio.x
		else:
			isPlayer = false
		
	if $RayCast2D_right.is_colliding():
		var collision = $RayCast2D_right.get_collider()
		if collision.name == "jugador":
			isPlayer = true
			_vel.x = -acceleracio.x * -1
		else:
			isPlayer = false

		
	
## Amb el Raycast determinem si l'enemic veu el jugador per disparar-lo
	if $RayCast2D_right.is_colliding() or $RayCast2D_left.is_colliding():
		var collisionR = $RayCast2D_right.get_collider()
		var collisionL = $RayCast2D_left.get_collider()
		## evitem que els enemics es disparin entre ells
		if collisionR != null and collisionR.name == "jugador" or collisionL != null and collisionL.name == "jugador":
			if $Timer.is_stopped():
				$Timer.start()
	else:
		if not $Timer.is_stopped():
			$Timer.stop()
	
	## girem l'animació depenent de la direcció
	if _vel.x > 0: 
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	else: 
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	

## Funcio per disparar l'arma l'hi passem per parametre la posició de que encara l'enemic (dreta o esquerra)
func shoot(direction):
		b = bullet.instance()
		b.init(direction) 
		get_parent().add_child(b)
		b.global_position = $Position2D.global_position
		
## Si la bala toca l'enemic el matem
func _on_BulletHit_area_entered(area: Area2D) -> void:
	$AnimatedSprite.play("die")
	area.get_parent().queue_free()
	die()
	
func die() -> void:
	$AnimatedSprite.play("die")
	PlayerData.score +=100
	queue_free()

## un cop s'acaba el timer l'enemic dispara i depenent de la direcció dispara a dreta o esquerra
func _on_Timer_timeout() -> void:
	if _vel.x > 0 :
		$Position2D.position.x = 57
		shoot(false)
	else:
		$Position2D.position.x = -57 
		shoot(true)
	
