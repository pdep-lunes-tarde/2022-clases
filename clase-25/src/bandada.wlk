import ave.*

class OtraExcepcion inherits DomainException {
	
}

class Bandada {
	const aves
	
	method descansar() {
		aves.forEach { unAve => unAve.descansar() }
	}
	
	method tirarExcepcion() {
		throw new OtraExcepcion(message="algo salio mal")	
	}
	
	method volarA(destino) {
		try {
			self.tirarExcepcion()
			self.validarQuePuedenVolarA(destino)
			aves.forEach { unAve => unAve.volarA(destino) }			
		} catch excepcion: NoSePuedeVolarException {
			self.descansar()
		} catch excepcion: OtraExcepcion {
			self.volarA(destino)
		}
	}
	
	method validarQuePuedenVolarA(destino) {
		aves.forEach { unAve => unAve.validarQuePuedeVolarA(destino) }
	}
	
	method transportarA(destino) {
		self.validarQuePuedenVolarA(destino)
		aves.forEach { unAve => unAve.transportarA(destino) }
	}
}

