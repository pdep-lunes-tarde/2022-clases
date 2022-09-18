import wollok.game.*

object autos {
	const calle = new Calle(x=1)
	method jugar() {
		game.cellSize(55)
		game.width(10)
		game.height(20)
		calle.dibujarEn(game)
		auto.estasEn(calle)
		game.addVisual(auto)
		keyboard.right().onPressDo {
			auto.moverseADerecha()
		}
		keyboard.left().onPressDo {
			auto.moverseAIzquierda()
		}
		game.start()
	}
}

class Calle {
	const property x = 0
	method carriles() {
		return 7
	}
	
	method carrilCentral() {
		return (self.carrilIzquierdo() + self.carrilDerecho()) / 2
	}
	method carrilIzquierdo() {
		return x
	}
	method carrilDerecho() {
		return x + self.carriles() - 1
	}
	method dibujarEn(juego) {
		juego.height().times { n =>
			const seccion = new SeccionDeCalle()
			juego.addVisualIn(seccion, game.origin().up(n - 1).right(x))
			juego.onTick(300,
						 "avanzarCalle" + n.toString(),
						 { seccion.avanzar() })
		}
	}
}

class SeccionDeCalle {
	var image = "calle.png"
	method image() = image
	method avanzar() {
		if(image == "calle.png") {
			image = "calle-2.png"
		} else {
			image = "calle.png"
		}
	}
}

object auto {
	var property position = game.at(0, 0)
	var calle
	
	method image() = "auto.png"
	
	method moverseHorizontalmente(deltaX) {
		const nuevaX = (position.x() + deltaX)
							.min(calle.carrilDerecho())
							.max(calle.carrilIzquierdo())
		position = game.at(nuevaX, position.y())
	}
	method moverseAIzquierda() {
		self.moverseHorizontalmente(-1)
	}
	method moverseADerecha() {
		self.moverseHorizontalmente(1) 
	}
	method estasEn(unaCalle) {
		calle = unaCalle
		position = game.at(unaCalle.carrilCentral(), position.y())
	}
}