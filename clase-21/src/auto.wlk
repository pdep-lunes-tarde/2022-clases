import wollok.game.*

object auto {
	var position = game.at(1, 0)
	method position() {
		return  position
	}
	method image() = "auto.png"

	method moveteADerecha() {
		position = position.right(1) 
	}
	method moveteAIzquierda() {
		position = position.left(1) 
	}
	
}
