extends KinematicBody2D
#variables
export var Initialmovespeed=300
export var Dashspeed=500
export var fire_rate=0.2
export var dashtime=0.2

var MOVE_SPEED = Initialmovespeed
var canfire= true
var Jhealth=5
var canbehurt= true
var candash=true
var canpause=true
var canmove=true

onready var raycast = $Laser

 #funcion al inicio
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemigos", "set_player", self)
	$Laser.set("is_casting",false)

 #fisicas 2d
func _physics_process(delta):
	if canmove:
		charmove(delta)
 
func charmove(delta):
	if Input.is_action_pressed("dash") and candash:
		dash()
	var move_vec = Vector2()
	if Input.is_action_pressed("arriba"):
		move_vec.y -= 1
	if Input.is_action_pressed("abajo"):
		move_vec.y += 1
	if Input.is_action_pressed("izquierda"):
		move_vec.x -= 1
	if Input.is_action_pressed("derecha"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	look_at(get_global_mouse_position())

#iniciar el dash
func dash():
	candash=false
	$"Dash SFX".play()
	MOVE_SPEED=Dashspeed
	$"Timer".start(dashtime)

#finalizar el dash
func _on_Timer_timeout():
	MOVE_SPEED=Initialmovespeed
	yield(get_tree().create_timer(0.7),"timeout")
	candash=true

#funcion cada fps
func _process(_delta):
	$"../CanvasLayer/MarginContainer/Contenedor/Vida".value= Jhealth
	if Input.is_action_just_pressed("ui_cancel") and canpause:
		pause()
	if Input.is_action_pressed("disparar") and canfire:
		disparar()

#disparar
func disparar():
		canfire=false
		$AnimatedSprite.animation="shoot"
		$"Laser SFX".play()
		$Laser.set("is_casting",true)
		canmove=false
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("damage"):
			coll.damage()
		yield(get_tree().create_timer(0.2),"timeout")
		$Laser.set("is_casting",false)
		$AnimatedSprite.animation="idle_move"
		yield(get_tree().create_timer(0.1),"timeout")
		canmove=true
		yield(get_tree().create_timer(fire_rate-0.3),"timeout")
		canfire=true

#lastimar al jugador
func hurt():
	if canbehurt:
		Jhealth=Jhealth-1
		$"Hit SFX".play()
		$Camera/CameraShake.ShakeStart()
		$AnimatedSprite.animation="hit"
		canbehurt=false
		if Jhealth<=0:
			die()
		else:
			yield(get_tree().create_timer(0.5),"timeout")
			$AnimatedSprite.animation="idle_move"
			canbehurt=true

func die():
	canpause=false
	get_tree().paused=true
	$"../CanvasLayer/OverlayGameOver/MenuGameOver/ContenedorBotones/HBoxContainer/Reintentar".GameOverMenuOpen()

func pause():
	get_tree().paused=true
	$"../CanvasLayer/OverlayPausa/Menupausa/Continuar".Openmenu()

func _on_OptionButton_item_selected(index):
	if index==0:
		get_tree().call_group("enemigos","set_difficulty",0.3)
		get_tree().call_group("spawners","set_spawn_diff",0.3)
	if index==1:
		get_tree().call_group("enemigos","set_difficulty",1)
		get_tree().call_group("spawners","set_spawn_diff",1)
	if index==2:
		get_tree().call_group("enemigos","set_difficulty",3)
		get_tree().call_group("spawners","set_spawn_diff",3)
