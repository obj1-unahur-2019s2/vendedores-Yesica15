import Vendedores.*

class ClienteInseguro{
	method puedeSerAtendido(vendedor){
		return vendedor.esVersatil() and vendedor.esFirme()
	}
}

class ClienteDetallista{
	method puedeSerAtendido(vendedor){
		return vendedor.certificadosDeProductos().size() >= 3
	}
}

class ClienteHumanista{
	method puedeSerAtendido(vendedor){
		return vendedor.esVendedorFijo() or vendedor.esVendedorViajante()
	}
}