object verdadero {
	method y(unBooleano) {
		return unBooleano
	}
	
	method o(unBooleano) {
		return self
	}
	
	method negado() = falso
	
	method ifVerdadero(bloque) {
		bloque.apply()
	}
}

object falso {
	method y(unBooleano) {
		return self
	}
	method o(unBooleano) {
		return unBooleano
	}
	method negado() = verdadero

	method ifVerdadero(bloque) {
		
	}
}
