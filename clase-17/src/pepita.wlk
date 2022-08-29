object pepita {
	var energia = 55
	
	method energia() {
		return energia
	}
	
	method volar(kilometros){
		energia = energia - 5 * kilometros
	}
	
	method comer(gramos){
		energia = energia + gramos
	}
}

/*
 * Lo que queremos hacer:
 * pepita.energia()
 * pepita.volar(2)
 * pepita.energia()
 * pepita.comer(8)
 * pepita.energia()
 */
 