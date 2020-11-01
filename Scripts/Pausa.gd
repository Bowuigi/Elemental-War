extends TextureButton

onready var Anim= $"../Tween"

func _on_Pausa_mouse_entered():
	Anim.interpolate_property(
	self,"rect_scale",
	Vector2(1,1),Vector2(1.5,1.5),1,Tween.TRANS_EXPO,Tween.EASE_OUT)
	Anim.start()

func _on_Pausa_mouse_exited():
	Anim.interpolate_property(
	self,"rect_scale",
	Vector2(1.5,1.5),Vector2(1,1),1,Tween.TRANS_EXPO,Tween.EASE_OUT)
	Anim.start()


func _on_Pausa_pressed():
	get_tree().paused=true
	$"../OverlayPausa/Menupausa/Continuar".Openmenu()
