
class Alquimista {
	var suerte
	var salud
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
}

