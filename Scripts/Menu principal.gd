extends Control

onready var Anim = $"Pantalla/Button container/HBoxContainer/Tween"

func _on_Jugar_pressed():
	transicion.change_scene("res://Scenes/Main.tscn")


func _on_Jugar_mouse_entered():
	Anim.interpolate_property(
	$"Pantalla/Button container/HBoxContainer/Jugar","rect_min_size",
	Vector2(70,64),Vector2(90,84),1,Tween.TRANS_EXPO,Tween.EASE_OUT)
	Anim.start()

func _on_Jugar_mouse_exited():
	Anim.interpolate_property(
	$"Pantalla/Button container/HBoxContainer/Jugar","rect_min_size",
	Vector2(90,84),Vector2(70,64),1,Tween.TRANS_EXPO,Tween.EASE_OUT)
	Anim.start()
