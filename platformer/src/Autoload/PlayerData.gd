extends Node

##Script que ens permet guardar les dades del nostre jugador, com ara quants cops ha mort
##i la puntuació per matar els enemics.

##senyals per fer update de les dades un cop el jugador fa accions.

signal score_updated
signal player_died
signal lives_updated

## setget ens permet agafar les dades i posarles dins d'una var

var score: = 0 setget set_score
var deaths: = 0 setget set_deaths
var lives: = 3 setget set_lives



##Funció per resetejar totes les dades (morts, vides, punts)
func reset() -> void:
	score = 0
	lives = 3
	deaths = 0

## gestionem la puntuació
func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
## gestionem les morts
func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
	
## gestionem les vides
func set_lives(value: int) -> void:
	lives = value
		##if lives == 0: emit_signal("player_lost")
	emit_signal("lives_updated")

	
