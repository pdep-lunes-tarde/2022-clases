import wollok.game.*

object autos {
	method jugar() {
		game.cellSize(55)
		game.width(12)
		game.height(20)
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

object auto {
	var property position = game.at(0, 0)
	
	method image() = "auto.png"
	
	method moverseAIzquierda() {
		position = position.left(1)
	}
	method moverseADerecha() {
		position = position.right(1) 
	}
}