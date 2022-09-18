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
		trafico.activarEn(calle)
		game.addVisualIn(hud, game.at(game.width() - 2, game.height() - 1))
		game.onCollideDo(auto, { otro => auto.chocarCon(otro) })
		keyboard.right().onPressDo {
			auto.moverseADerecha()
		}
		keyboard.left().onPressDo {
			auto.moverseAIzquierda()
		}
		game.start()
	}
}

object trafico {
	method activarEn(unaCalle) {
		self.aparecerAutoAEsquivar(unaCalle)
	}
	method aparecerAutoAEsquivar(unaCalle) {
		const lentitudAuto = 100.randomUpTo(600)
		const autoAEsquivar = new AutoAEsquivar(
			position = game.at(unaCalle.carrilAlAzar(), game.height() + 1)
		)
		game.addVisual(autoAEsquivar)
		game.onTick(lentitudAuto, "avanzarAuto", { autoAEsquivar.avanzar() })
		game.schedule(1000.randomUpTo(3000),
			{ self.aparecerAutoAEsquivar(unaCalle) }
		)
	}
}

object hud {
	method text() = "Vidas: " + auto.vidas()
}

class AutoAEsquivar {
	var property position
	method image() = "auto-violeta.png"
	
	method avanzar() {
		position = position.down(1)
	}
	method chocasteConAuto(unAuto) {
		unAuto.perderVida()
	}
}

class Calle {
	const property x = 0
	method carriles() {
		return 7
	}
	
	method carrilAlAzar() {
		return self.carrilIzquierdo().randomUpTo(self.carrilDerecho())
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
	method chocasteConAuto(unAuto) {}
}

object auto {
	var property position = game.at(0, 0)
	var calle
	var property vidas = 3

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
	method chocarCon(otro) {
		otro.chocasteConAuto(self)
	}
	method perderVida() {
		vidas -= 1
	}
}