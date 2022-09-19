import wollok.game.*
import calle.*

object auto {
	var vidas = 3
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
	method vidas() {
		return vidas 
	}
	method chocaCon(algo) {
		algo.chocasteConAuto(self)
	}
	method perderVida() {
		vidas -= 1
	}
	
}
