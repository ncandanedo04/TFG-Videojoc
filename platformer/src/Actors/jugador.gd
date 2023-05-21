## Classe que gestiona el nostre jugador, extes de la classe Actor 
## 
extends Actor

export var xafat_impuls = 1000.0
##Precarreguem la bala per poder-la utilitzar dins de la classe jugador
onready var bullet = preload("res://src/Objects/Bullet.tscn")
var b 

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_vel = calcular_xafar_velocitat(_vel, xafat_impuls)

## detectem si l'enemic ens toca per matar-nos
func _on_EnemyDetector_body_entered(body: Node) -> void:
	die() ##funcio per matar el jugador

# funcó del motor per processar les físiques per cada frame
# està pensada per gestionar com interactuen per exemple els nostres jugador
# o enemics amb l'entorn
func _physics_process(delta: float) -> void:
	
	var is_jump_interrupted:= Input.is_action_just_released("jump") and _vel.y < 0.0
	var direccio: = get_dirreccio()
	#_vel = acceleracio * direccio
	_vel = calcular_moviment_velocitat(_vel, acceleracio, direccio, is_jump_interrupted)
	var snap: = Vector2.DOWN * 50.0 if direccio.y == 0.0 else Vector2.ZERO
	#Vector2.UP per fer que move and slide reconegui el salt del jugador
	_vel = move_and_slide_with_snap(
		_vel, snap, FLOOR_NORMAL, true, 4, PI/3.0
	)
	spriteDir() 
	shoot($AnimatedSprite.flip_h)
	
##Funcio per disparar l'arma l'hi passem per parametre la direcció 
func shoot(direction):
	if Input.is_action_just_pressed("shoot"):
		b = bullet.instance()
		b.init(direction) 
		get_parent().add_child(b)
		b.global_position = $Position2D.global_position
		

func spriteDir() -> void:
	if Input.is_action_pressed("move_right"):
		$Position2D.position.x = 57
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("move_left"):
		$Position2D.position.x = -57
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("jump"):
		$AnimatedSprite.play("jump")
	elif Input.is_action_pressed("shoot"):
		$AnimatedSprite.play("shoot")
	else:
		$AnimatedSprite.play("Idle")

## funció que ens retorna la direccó del nostre jugador
func get_dirreccio() -> Vector2:
	return Vector2(
	## classe input per gestionar els moviments que fa el jugador
	##retonra un decimal 0 / 1 representant la intensitat d'aquesta acció (per exemple un joy)
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), # valor X
		# valor Y , per saltar ha de ser negatiu ja que dins el motor està invertit
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 0.0
	)


func calcular_moviment_velocitat(
		## valors d'entrada a la funció
		linear_velocity: Vector2,
		accele: Vector2,
		direccio: Vector2,
		is_jump_interrupted: bool
		) -> Vector2:
	var out = linear_velocity
	out.x = accele.x * direccio.x
	out.y += gravetat * get_physics_process_delta_time()
	if direccio.y == -1.0: 
		out.y = accele.y * direccio.y
		#ens permet modular l'intensitat del salt
	if is_jump_interrupted:
		out.y = 0.0
	return out

## substituim el valor de la Y pel valor del impuls, similar a com es fa al saltar.
func calcular_xafar_velocitat(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	
##Funció que elimina al jugador i ens suma una mort al comptador
func die() -> void:
	$AnimatedSprite.play("die")
	PlayerData.deaths +=1
	PlayerData.lives -=1
	if PlayerData.lives > 0:
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene("res://src/Screens/EndScreen_lost.tscn")
	
		




