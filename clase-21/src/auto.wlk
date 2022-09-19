import wollok.game.*

object auto {
	var position = game.at(1, 0)
	method position() {
		return  position
	}
	method image() = "auto.png"

	method moveteADerecha() {
		self.moverseHorizontalmente(1)
	}
	method moveteAIzquierda() {
		self.moverseHorizontalmente(-1)
	}
	method moverseHorizontalmente(deltaX) {
		const nuevaX = (position.x() + deltaX).max(0).min(6)
		position = game.at(nuevaX, position.y())
	}
	
}
