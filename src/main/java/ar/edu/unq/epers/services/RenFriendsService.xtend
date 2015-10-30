package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.homes.FriendsHome

class RenFriendsService {
	
	
	
	
	private def createHome(GraphDatabaseService graph) {
		new FriendsHome(graph)
	}
	
	def crearAmistad(Usuario quienAgrega , Usuario quienAgregar) {
		GraphServiceRunner::run[
			createHome(it).agregarNuevaRelacion(quienAgrega,quienAgregar)
			null
		]
	}
	
	def misAmigosDirectos(Usuario quienBuscaAmigos) {
		GraphServiceRunner::run[
			createHome(it).buscarRelacionados(quienBuscaAmigos)
		]
	}
	
	def enviarMensajeAAmigo(Usuario quienEnvia , String nombreUsuario , String mensajeAEnviar) {
		GraphServiceRunner::run[
			var Usuario receiver = createHome(it).buscarAmigo(nombreUsuario)
			receiver.nuevoMensaje(mensajeAEnviar)
			null
		]
	}
	
//	def misAmigosIndirectos() {
//		GraphServiceRunner::run[
//			createHome(it).eliminarNodo(persona)
//			null
//		]
//	}
	
	
}