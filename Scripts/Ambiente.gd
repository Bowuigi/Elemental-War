extends WorldEnvironment

func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		environment.set_glow_enabled(true)
		environment.set_tonemap_white(5)
	else:
		environment.set_glow_enabled(false)
		environment.set_tonemap_white(2)
