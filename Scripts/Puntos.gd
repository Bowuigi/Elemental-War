extends Label

var puntos= 0
var pointstxt=str("Puntos: " + str(puntos))

func addpoints(amount):
	puntos= puntos + amount
	pointstxt=str("Puntos: " + str(puntos))
	self.set_text(pointstxt)

func gameover():
	get_tree().call_group("finalpoints","setpoints",str(pointstxt))
