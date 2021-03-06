import subastas.*
import publicaciones.*

class Usuario {

	var publicacionesDelUsuario = []
	var subastasGanadas = []
	var publicacionesOfertadas = []
	var deudas = 0
	
	method venta(objetoAPublicar, dia, mes, anio, precioBase, clase) {
		var fechaDeFinalizacion = new Date(dia, mes, anio)
		var publicacion = new Publicacion(objeto = objetoAPublicar, fecha = fechaDeFinalizacion, usuario = self, oferta = precioBase)
		self.agregarPublicacion(publicacion)
		subasta.agregarSubasta(publicacion)
	}

	method agregarPublicacion(publicacionNueva) {
		publicacionesDelUsuario.add(publicacionNueva)
	}

	method ofertar(objeto, oferta) {
		var publicacion = subasta.buscarObjeto(objeto)
		publicacion.recibirOfertaDe(self, oferta)
		self.agregarOferta(publicacion)
	}

	method agregarOferta(publicacion) {
		publicacionesOfertadas.add(publicacion)
	}

	method comisionACobrar() {
		deudas = deudas + publicacionesDelUsuario.forEach({ c => c.comision() }).sum()
	}

	method subastaGanada(publicacion) {
		subastasGanadas.add(publicacion)
	}

	method cerrarSubastas(unaFecha) {
		publicacionesDelUsuario.filter(unaFecha).forEach({ c => c.cerrarSubasta()})
	}

	method esGanador(publicacion) {
		if (publicacionesOfertadas.contains(publicacion)) self.buscarSubastaGanada(publicacion) else self.error("no oferto en esa publicacion")
	}

	method buscarSubastaGanada(publicacion) {
		subastasGanadas.contains(publicacion)
	}
	
	method buscarSubastaOfertada(publicacion){
		publicacionesOfertadas.find(publicacion)
	}

	method esLooser() {
		var publicacionesAbiertas = self.publicacionesOfertadasAunAbiertas()
		return subastasGanadas.removeAll(publicacionesAbiertas)
	}

	method publicacionesOfertadasAunAbiertas() {
		return publicacionesOfertadas.filter({ c => !c.estadoDeLaPublicacion() })
	}

}

object sinUsuario {

}

