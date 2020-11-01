extends Node2D

onready var anim= $ShakeTween
onready var camara= get_parent()

var amplitud=0
var prioridad=0

func ShakeStart(duracion= 0.2,frecuencia= 5,amplitud= 6, prioridad= 0):
	if prioridad >= self.prioridad:
		self.prioridad=prioridad
		self.amplitud=amplitud
		$Duracion.wait_time= duracion
		$Frecuencia.wait_time= 1/float(frecuencia)
		$Duracion.start()
		$Frecuencia.start()
		NuevoShake()

func NuevoShake():
	var rand= Vector2()
	rand.x=rand_range(-amplitud,amplitud)
	rand.y=rand_range(-amplitud,amplitud)
	anim.interpolate_property(camara,"offset",camara.offset,rand,$Frecuencia.wait_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	anim.start()

func Reiniciar():
	anim.interpolate_property(camara,"offset",camara.offset,Vector2(0,0),$Frecuencia.wait_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	anim.start()
	prioridad=0

func _on_Duracion_timeout():
	NuevoShake()


func _on_Frecuencia_timeout():
	Reiniciar()
