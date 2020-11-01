extends Button

func _pressed():
	get_tree().paused=false
	Closemenu()

func Closemenu():
	$"../..".hide()

func Openmenu():
	$"../..".show()
