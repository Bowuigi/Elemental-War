extends TextureButton

func _on_Music_Toggle_toggled(button_pressed):
	if button_pressed:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
