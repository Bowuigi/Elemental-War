extends Button

func _on_Reintentar_pressed():
	transicion.reload_current_scene()
	get_tree().paused=false
	yield(get_tree().create_timer(0.3),"timeout")
	$"../../../..".hide()

func GameOverMenuOpen():
	$"../../../..".show()
	$"../../../../../MarginContainer".hide()
	$"../../../../../Pausa".hide()
	get_tree().call_group("puntos","gameover")


func _on_VolverAlMenu_pressed():
	transicion.change_scene("res://Scenes/Menu principal.tscn")
	get_tree().paused=false
	yield(get_tree().create_timer(0.3),"timeout")
	$"../../../..".hide()
