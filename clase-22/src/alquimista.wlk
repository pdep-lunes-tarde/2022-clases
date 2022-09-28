
class Alquimista {
	var suerte = 0
	var salud = 0
	const ventas = new Dictionary()
	method suerte() = suerte
	method salud() = salud
	method aumentarSalud(cantidad) {
		salud += cantidad 
	}
	method aumentarSuerte(cantidad) {
		suerte += cantidad
	}
	method disminuirSalud(cantidad) {
		salud -= cantidad
	}
	method tomar(pocion) {
		pocion.afectar(self)
	}
	
	method vender(pocion, alquimista) {
		if(not ventas.containsKey(alquimista)) {
			ventas.put(alquimista, [])
		}
		const comprasDeAlquimista = ventas.get(alquimista)
		comprasDeAlquimista.add(pocion)
	}
	
	method cantidadClientes() = ventas.size()
	
	method gourmet() {
		return ventas.values().flatten().all { pocion =>
			pocion.rareza() >= 5
		}
	}
	
	method clienteFavorito() {
		return self.compradores().max { comprador => 
			self.cantidadDeVecesQueCompro(comprador)
		}
	}
	
	method compradores() = ventas.keys()
	
	method cantidadDeVecesQueCompro(comprador) =
		ventas.get(comprador).size()
}

//class Venta {
//	const property comprador
//	const property pocion
//	
//	method dePocionGourmet() = pocion.rareza() >= 5
//}
