// encapsulamiento: solo un objeto
// puede usar y modificar sus
// variables internas
object pepita {
	var energia = 55

	method energia() {
		return energia
	}
	method vola(kms) {
		energia = energia - kms * 5
	}
	method come(gramos) {
		var nuevaEnergia = energia + gramos
		energia = nuevaEnergia
	}

	method nombre() {
		return "pepita"
	}
	method nombreImagen() {
		return self.nombre()
	}
}

object josefa {
	var energiaInicial = 100
	var gramosComidos = 0
	var kmsVolados = 0

	method energia() {
		return energiaInicial + 5 * gramosComidos - 3 * kmsVolados
	}
	method come(gramos) {
		gramosComidos = gramos + gramosComidos
	}
	method vola(kms) {
		kmsVolados = kms + kmsVolados
	}
	method nombre() {
		return "josefa"
	}
	method nombreImagen() {
		return self.nombre()
	}
	method estado() {
		if(gramosComidos == 0 && kmsVolados > 0) {
			return "explotada"
		} else if(gramosComidos > kmsVolados) {
			return "bonita y gordita"
		} else if(self.energia() > energiaInicial) {
			return "energica"
		} else {
			return "indiferente"
		}
	}
}

object entrenador {
	var pajaro = beti

	method asignarA(unPajaro) {
		pajaro = unPajaro
	}
	
	method entrena() {
		pajaro.come(10)
		pajaro.vola(20)
		if(pajaro.energia() < 20) {
			pajaro.come(10)	
		} else {
			pajaro.come(2)
		}	
	}
	
	method nombrePajaroAsignado() {
		return pajaro.nombre()
	}
	method energiaPajaroAsignado() {
		return pajaro.energia() 
	}
	method nombreImagenPajaroAsignado() {
		return pajaro.nombreImagen() 
	}
}

object beti {
	var companiera = pepita

	method energia() {
		return companiera.energia()
	}

	method companiera(unPajaro) {
		companiera = unPajaro 
	}

	method come(gramos) {
		companiera.come(gramos / 2)
	}

	method vola(kms) {
		companiera.vola(kms)
	}
	method nombre() {
		return "beti"
	}
	method nombreImagen() {
		return "beti-con-" + companiera.nombreImagen()
	}
}
