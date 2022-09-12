object kiosko {
	method vender() = new Galletita()
}

class Galletita {
	var masa = 100
	var cantidadMembrillo = 0
	
	method masa() {
		return masa
	}
	
	method calorias() {
		return masa * 3 + cantidadMembrillo
	}
	
	method comer(cantidadMasa) {
		masa -= cantidadMasa.min(self.masa())
	}
}

class Persona {
	var calorias = 0
	
	method comer(galletita) {
		calorias += galletita.calorias()
		galletita.comer(galletita.masa())
	}
}
