class SeccionDeCalle {
	method image() = "calle.png"
}

object calle {
	var property positionX = 0
	method cantidadDeCarriles() {
		return 7
	}
	method carrilDerecho() {
		return positionX + self.cantidadDeCarriles() - 1
	}
	method carrilIzquierdo() {
		return positionX
	}
	method carrilCentral() {
		return (self.carrilIzquierdo() + self.carrilDerecho()) / 2
	}
	
	method dibujateEn(unJuego) {
		unJuego.height().times { n => 
		unJuego.addVisualIn(new SeccionDeCalle(),
						    unJuego.at(self.carrilIzquierdo(), n - 1)
		)
		}
	}
}