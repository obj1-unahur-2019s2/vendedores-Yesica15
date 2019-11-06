import Centros.*

class Certificaciones{
	var property puntos
	var property sonDeProductos
}

class Vendedor{
	var property certificaciones = #{}
	
	method puedeTrabajar(ciudad)
	
	method esVersatil(){
		return self.tieneCantidadMinimaCert() and 
		self.tieneAlgunCertDeProducto() and self.tieneAlgunCertNoDeProducto()
	}
	
	method tieneCantidadMinimaCert(){
		return certificaciones.size() >= 3
	}
	
	method tieneAlgunCertDeProducto(){
		return certificaciones.any({cert => cert.sonDeProductos()})
	}
	
	method tieneAlgunCertNoDeProducto(){
		return certificaciones.any({cert => not cert.sonDeProductos()})
	}
	
	method esFirme(){
		return self.sumaPuntosCert() >=30
	}
	
	method sumaPuntosCert(){
		return certificaciones.sum({cert => cert.puntos()})
	}
	
	method esInfluyente()
	
	method esGenerico(){
		return self.tieneAlgunCertNoDeProducto()
	}
	
	method agregarCertificado(cert){
		certificaciones.add(cert)
	}
	
	method tieneAfinidad(centro){
		return self.puedeTrabajar(centro.ciudad())		
	}
	
	method esCandidato(centro){
		return self.esVersatil() and self.tieneAfinidad(centro)
	}
	
	method certificadosDeProductos(){
		return certificaciones.map({cert => cert.sonDeProductos()})
	}
	
	method esVendedorFijo() = false
	method esVendedorViajante() = false
}

class VendedorFijo inherits Vendedor{
	var property ciudadVive
	
	override method puedeTrabajar(ciudad){
		return ciudadVive == ciudad
	}
	
	override method esInfluyente(){ return false}
	
	override method esVendedorFijo() = true
}

class VendedorViajante inherits Vendedor{
	var property provinciasHabilitadas = #{}
	
	override method puedeTrabajar(ciudad){
		return provinciasHabilitadas.any({provincia => ciudad.provincia() == provincia})
	}
	
	override method esInfluyente(){ return self.poblacionQueInfluencia()>=10000000}
	
	method poblacionQueInfluencia(){
		return provinciasHabilitadas.sum({per => per.poblacion()})
	}
	
	override method esVendedorViajante() = true
}

class ComercioCorresponsal inherits Vendedor{
	var property ciudades = #{}
	
	override method puedeTrabajar(ciudad){
		return ciudades.any({ciu => ciudad == ciu})
	}
	
	override method esInfluyente(){ 
		return self.cantCiudadesParaInfluyente() or self.cantProvinciasParaInfluyente()
	}
	
	method cantCiudadesParaInfluyente(){
		return ciudades.size() >=5
	}
	
	method cantProvinciasParaInfluyente(){
		return self.listaProv().size() >=3
	}
	
	method listaProv(){
		return ciudades.map({ciu => ciu.provincia()}).asSet()
	}
	
	override method tieneAfinidad(centro){
		return super(centro) and ciudades.any({ciu => not centro.puedeCubrir(ciu)})
	}
}

class Ciudad{
	var property provincia
}

class Provincia{
	var property poblacion
}