extends CanvasLayer

func change_scene(scene):
	$Anim.play("fade_in")
	yield($Anim,"animation_finished")
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene(scene)
	$Anim.play("fade_out")

func reload_current_scene():
	$Anim.play("fade_in")
	yield($Anim,"animation_finished")
	yield(get_tree().create_timer(1),"timeout")
	get_tree().reload_current_scene()
	$Anim.play("fade_out")
