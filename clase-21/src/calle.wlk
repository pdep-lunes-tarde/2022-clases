class SeccionDeCalle {
	var imagen = "calle.png"
	method alternarImagen() {
		if(imagen == "calle.png") {
			imagen = "calle-2.png"
		} else {
			imagen = "calle.png"
		}
	}
	method image() = imagen
	method chocasteConAuto(unAuto) {
		
	}
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
			const seccionCalle = new SeccionDeCalle() 
			unJuego.addVisualIn(seccionCalle,
						    unJuego.at(self.carrilIzquierdo(), n - 1)
			)
			unJuego.onTick(100,
					"animarCalle",
					{ seccionCalle.alternarImagen() })
		}

	}
}