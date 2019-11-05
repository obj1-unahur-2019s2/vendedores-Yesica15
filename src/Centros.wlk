import Vendedores.*

class CentrosDistribucion{
	var property ciudad
	var property vendedores = #{}
	
	method agregarVendedor(vende){
		if (self.vendedorPertenece(vende)){
			self.error("Error... Vendedor ya registrado")
		}
		else{ vendedores.add(vende)}
		
	}
	
	method vendedorPertenece(vende){
		return vendedores.any({vent => vent == vende})
	}
	
	method vendedorEstrella(){
		return vendedores.max({vent => vent.sumaPuntosCert()})
	}
	
	method puedeCubrir(ciudadTrab){
		return vendedores.any({vent => vent.puedeTrabajar(ciudadTrab)})
	}
	
	method vendedoresGenericos(){
		return vendedores.map({vent => vent.esGenerico()}).asSet()
	}
	
	method esRobusto(){
		return self.vendedoresFirmes().size() >= 3
	}
	
	method vendedoresFirmes(){
		return vendedores.map({vent => vent.esFirme()}).asSet()
	}
	
	method repartirCertificado(cert){
		vendedores.forEach({vend => vend.agregarCertificado(cert)})
	}

}
