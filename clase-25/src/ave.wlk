class NoSePuedeVolarException inherits DomainException {
}

class Ave {
	var energia
	var ciudad
	method validarQuePuedeVolarA(otraCiudad) {
		if(self.energiaRequeridaParaVolarA(otraCiudad) > energia){
			throw new NoSePuedeVolarException(message="No tengo energia suficiente para volar")
		}
	}
	method volarA(otraCiudad) {
	    self.validarQuePuedeVolarA(otraCiudad)
	    energia -= ciudad.distanciaHasta(otraCiudad)
	    ciudad = otraCiudad
	}

	method transportarA(otraCiudad) {
		const productoATransportar = ciudad.produccion()
		self.volarA(otraCiudad)
		ciudad.dar(productoATransportar)
	}

	method energiaRequeridaParaVolarA(otraCiudad) = ciudad.distanciaHasta(otraCiudad)
	method energia() = energia
	method ciudad() = ciudad
	method descansar() {
		energia += 20
	}

}



	