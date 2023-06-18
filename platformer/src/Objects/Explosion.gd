extends Node2D

signal explosion_ended

onready var _smoke := $mainExplosion/smoke
onready var _shards := $mainExplosion/shards
onready var _fire := $mainExplosion
onready var _hitbox := $hitbox
onready var _sound_explosion := $explosion_sound


func _ready():
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	_explode()
	
func _explode():
	_smoke.emitting = true
	_shards.emitting = true
	_fire.emitting = true
	_sound_explosion.play()
	for body in _hitbox.get_overlapping_bodies():
		if body.has_method("die"):
			body.die()
	yield(get_tree().create_timer(1.1), "timeout")
	emit_signal("explosion_ended")
	queue_free()

