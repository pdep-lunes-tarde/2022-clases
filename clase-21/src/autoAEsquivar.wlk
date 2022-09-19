class AutoAEsquivar {
	var property position
	method image() = "auto-violeta.png"
	method chocasteConAuto(unAuto) {
		unAuto.perderVida()
	}
	method avanzar() {
		position = position.down(1)
	}
}
