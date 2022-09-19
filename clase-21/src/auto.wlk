import wollok.game.*
import calle.*

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
		const nuevaX = (position.x() + deltaX)
							.max(calle.carrilIzquierdo())
							.min(calle.carrilDerecho())
		position = game.at(nuevaX, position.y())
	}
	method ubicarteParaEmpezar() {
		position = game.at(calle.carrilCentral(), 0) 
	}
	
}
