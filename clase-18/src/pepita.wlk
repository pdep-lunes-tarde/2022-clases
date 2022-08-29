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
}

object josefa {
	method energia() {
		return 100
	}
}
