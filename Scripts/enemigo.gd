extends KinematicBody2D

export var Base_Move_Speed = 30

onready var raycast = $RayCast2D

#H Na Ca F O Hg Fe C N P Al As
var atomo=1
var atomamount=13

var health = 3
var player = null
var elementname=""
var dificultad=1
var move_Speed=Base_Move_Speed*dificultad


func _ready():
	add_to_group("enemigos")
	match atomo:
		1:
			elementname="H"
			health= 1
		2:
			elementname="P"
			health= 3
		3:
			elementname="C"
			health= 2
		4:
			elementname="Ca"
			health= 2
		5:
			elementname="N"
			health= 3
		6:
			elementname="Sc"
			health= 1
		7:
			elementname="As"
			health= 3
		8:
			elementname="F"
			health= 1
		9:
			elementname="K"
			health= 1
		10:
			elementname="Hg"
			health= 6
		11:
			elementname="Fe"
			health= 2
		12:
			elementname="Na"
			health= 1
		13:
			elementname="B"
			health= 5

func _process(_delta):
	move_Speed=Base_Move_Speed*dificultad
	$"Info container/Element container/Element info".set_text(elementname)
	$"Info container/Hp container/HBoxContainer/HP".set_text(str(health))
	

func _physics_process(delta):
	if player == null:
		return
	var vec_to_player = player.get_global_position() - get_global_position()
	vec_to_player = vec_to_player.normalized()
	$RayCast2D.look_at(player.get_global_position())
	move_and_collide(vec_to_player * move_Speed * delta)
 
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Jugador":
			coll.hurt()
 
func kill(getpoint):
	if getpoint:
		get_tree().call_group("puntos","addpoints",1)
	queue_free()
 
func damage(sfx=true,getpoint=true):
	health=health-1
	if sfx:
		$"Hit SFX".play()
	$AnimatedSprite.play("Hit")
	if health<=0:
		kill(getpoint)
	else:
		yield(get_tree().create_timer(0.2),"timeout")
		$AnimatedSprite.play("Normal")

func set_player(p):
	player = p



func set_difficulty(diff):
	dificultad=diff
	return diff


func _on_Lifetime_timeout():
	damage(false,false)
