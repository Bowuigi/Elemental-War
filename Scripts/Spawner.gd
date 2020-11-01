extends Node2D

var enemigo = preload("res://Scenes/enemigo.tscn")
var canbespawned=true
var startingdiff=1

func _ready():
	add_to_group("spawners")

func _process(_delta):
	randomspawn(get_global_position())
#	spawn(get_global_position(),1)

func set_spawn_diff(difficulty):
	startingdiff=difficulty

#aparecer enemigo
func spawn(spawnpoint,atom):
	if canbespawned:
		var instance= enemigo.instance()
		instance.position= spawnpoint
		instance.atomo= atom
		instance.player=$"../../Jugador"
		instance.dificultad=startingdiff
		add_child(instance)
		canbespawned=false
		yield(get_tree().create_timer(5),"timeout")
		canbespawned=true

func randomspawn(spawnpoint):
	if canbespawned:
		var rinstance= enemigo.instance()
		rinstance.position= spawnpoint
		rinstance.atomo= int(floor(rand_range(1,12)))
		rinstance.player=$"../../Jugador"
		rinstance.dificultad=startingdiff
		add_child(rinstance)
		canbespawned=false
		yield(get_tree().create_timer(5),"timeout")
		canbespawned=true
