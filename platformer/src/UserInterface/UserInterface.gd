extends Control

##ens permet preparar variables en memòria per una millor gestió
onready var scene_tree: = get_tree()
##Aquesta variable ens retorna un node predefinit
onready var pause_overly: ColorRect = get_node("PauseOverly")

onready var score: Label = get_node("Score")
onready var lives: Label = get_node("Lives")
onready var pause_title: Label = get_node("PauseOverly/Title")


##variable que ens permet gestionar si el joc esta pausat o no..
var paused: = false setget set_paused

##Carreguem les dades del jugador
func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("lives_updated", self, "update_interface")
	PlayerData.connect("player_lost", self, "_on_PlayerData_player_died")
	
	update_interface()

##Mostrem la pantalla de mort.
func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = "¡ YOU DIED !"
	
##Revisem si l'usuari prem "ESC" per pausar el joc i mostrar el menù de pausa
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		self.paused = not paused ##fem servir self per assegurarnos de que passa per la funció "set_paused"
		scene_tree.set_input_as_handled() ## evitem que els events de teclat i ratolí es propagin per el joc (moure el pnj dins del menù de pausa)

##funcio per actualitzar les dades del la UI
func update_interface() -> void:
	score.text = "SCORE: %s" % PlayerData.score
	lives.text = "LIVES: %s" % PlayerData.lives
	
## Pausem el joc i tots els seus NODES
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overly.visible = value
