package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.homes.FriendsHome
import ar.edu.unq.epers.model.Mail

class RenFriendsService {
	
	
	
	new(){}
	
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
			var mail = new Mail(quienEnvia.nombreDeUsuario,nombreUsuario,"Servicio de correo RenFriends",mensajeAEnviar)
			createHome(it).envioDeMensaje(quienEnvia,mail,nombreUsuario)
			null
		]
	}
	
	def agregarNuevoUsuario(Usuario nuevoUsuario){
		GraphServiceRunner::run[
			createHome(it).crearNodo(nuevoUsuario)
		]
	}
	
	def agregarNuevoMail(Mail nuevoMail){
		GraphServiceRunner::run[
			createHome(it).crearNodo(nuevoMail)
		]
	}
	
//	def misAmigosIndirectos() {
//		GraphServiceRunner::run[
//			createHome(it).eliminarNodo(persona)
//			null
//		]
//	}
	
	
}