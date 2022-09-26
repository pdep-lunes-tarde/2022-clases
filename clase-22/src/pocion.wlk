
class Pocion {
	const ingredientes = new List() // es lo mismo que []

	method cantidadIngredientes() = ingredientes.size()
	
	method agregarIngrediente(unIngrediente) {
		ingredientes.add(unIngrediente)
	}
	
	method rareza() {
		if(self.cantidadIngredientes() == 0) {
			return 0
		}
		// map rareza ingredientes
		// ingredientes.map { i => i.rareza() }
		const rarezas = ingredientes.map({ unIngrediente => 
			unIngrediente.rareza()
		})
		const rarezaTotal = rarezas.sum()

		return rarezaTotal / self.cantidadIngredientes()
	}
	
	method afectar(alquimista) {
		ingredientes.forEach { ingrediente =>
			ingrediente.afectar(alquimista)
		}
	}
	
	method tieneIngrediente(unIngrediente) =
		ingredientes.contains(unIngrediente)
	
	method destilar() {
//		ingredientes = ingredientes.filter({
//			unIngrediente => unIngrediente.rareza() > 5
//		})
		ingredientes.removeAllSuchThat({
			unIngrediente => unIngrediente.rareza() <= 5
		})
	}
	
	method hervir() {
		ingredientes.forEach { unIngrediente =>
			unIngrediente.hervir()
		}
	}
}

class BigoteDeGato {
	method rareza() = 1

	method afectar(alquimista) {
		alquimista.aumentarSalud(1)
		alquimista.aumentarSuerte(1)
	}
	
	method hervir() {}
}

class Trebol {
	var hojas

	method hojas() = hojas

	method rareza() {
		if(hojas == 4) {
			return 20
		} else {
			return 1
		}
	}
	
	method afectar(alquimista) {
		if(hojas == 4) {
			alquimista.aumentarSuerte(20)
		}
	}
	
	method hervir() {
		hojas -= 1
	}
}

class HiedraVenenosa {
	var concentracionDeVeneno
	
	method concentracionDeVeneno() = concentracionDeVeneno 
	
	method rareza() = concentracionDeVeneno
	
	method afectar(alquimista) {
		alquimista.disminuirSalud(concentracionDeVeneno * 2)		
	}
	
	method hervir() {
		concentracionDeVeneno = concentracionDeVeneno * 2
	}
}


