class Estudiante {
	var property energia = 0
	var property horasDeEstudio = 0
	var property estresado = false
	const rutinaDeEstudio = []
  
	method cansarse(cantidad) {
		energia = (energia - cantidad).max(0)
	}

	method recuperarEnergia(cantidad) { energia += cantidad }

	method concentracion() = if(estresado) energia / 2 else energia

	method concentrado() = self.concentracion() > 50

	method preparado() = horasDeEstudio > 40 && self.concentrado()

	method hacerRutinaDeEstudio() {
		rutinaDeEstudio.forEach { actividad =>
			if(actividad.laPuedeHacer(self))
			actividad.hacerse(self)
		}
	}
}

