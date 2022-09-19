import wollok.game.*
import calle.*
import auto.*
import vidas.*
import autoAEsquivar.*

object juegoDeAutos {
	method jugar() {
		game.cellSize(55)
		game.width(9)
		game.height(10)
		calle.dibujateEn(game)
		auto.ubicarteParaEmpezar()
		game.addVisual(auto)
		game.addVisualIn(vidas, game.at(calle.carrilDerecho() + 1, game.height() - 1))
		trafico.activar()
		game.onCollideDo(auto, {
			algo => auto.chocaCon(algo)
		})
		keyboard.right().onPressDo {
			auto.moveteADerecha()
		}
		keyboard.left().onPressDo {
			auto.moveteAIzquierda()
		}
		game.start()
	}
}

object trafico {
	method activar() {
		self.aparecerVariosAutos()
	}
	method aparecerVariosAutos() {
		self.aparecerAutoAEsquivar()
		game.schedule(500.randomUpTo(1000), 
			{ self.aparecerVariosAutos() }
		)
	}
	method aparecerAutoAEsquivar() {
		const autoAEsquivar = new AutoAEsquivar(
				position=game.at(
					calle.carrilAlAzar(),
					game.height() + 1
				)
		) 
		game.addVisual(autoAEsquivar)
		game.onTick(50.randomUpTo(800), "avanzarAuto",
					{ autoAEsquivar.avanzar() }
		)
	}
}