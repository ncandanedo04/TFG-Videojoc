## La classe Actor ens permet moure els
## jugadors i enemics del nostre prototip

## Extenem la classe KinematicBody2D
extends KinematicBody2D 
class_name Actor

const FLOOR_NORMAL: = Vector2.UP
#creem una variable Vector2 per simular l'acceleració
export var acceleracio: = Vector2(300.0, 1000.0)
#creem una variable float de per simular la gravetat
export var gravetat: = 3500.0
#creem una variable de tipus vetor per guardar la velocitat de moviment
var _vel: = Vector2.ZERO


