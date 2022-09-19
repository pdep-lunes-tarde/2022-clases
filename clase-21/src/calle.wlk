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
	
}