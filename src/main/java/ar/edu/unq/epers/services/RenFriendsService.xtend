package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.homes.FriendsHome
import ar.edu.unq.epers.model.Mail
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import ar.edu.unq.epers.model.TipoDeRelacion


class RenFriendsService {
	
	
	
	new(){}
	
	private def createHome(GraphDatabaseService graph) {
		new FriendsHome(graph)
	}
	
	def crearAmistad(Usuario quienAgrega , Usuario quienAgregar)throws UsuarioNoExisteException {
		GraphServiceRunner::run[
			createHome(it).agregarNuevaRelacion(quienAgrega,quienAgregar)
			null
		]
	}
	
	def sonAmigos(Usuario usuarioAVerificar,Usuario uno ) {
		var amigos = this.misAmigosDirectos(usuarioAVerificar)
		return amigos.contains(uno)
	}
	
	def misAmigosDirectos(Usuario quienBuscaAmigos) {
		GraphServiceRunner::run[
			createHome(it).buscarRelacionados(quienBuscaAmigos)
		]
	}
	
	def mensajesEnviados(Usuario user){
		GraphServiceRunner::run[
			createHome(it).buscarMensajes(user,TipoDeRelacion.EMISOR)
		]
	}
	
	def mensajesRecibidos(Usuario user){
		GraphServiceRunner::run[
			createHome(it).buscarMensajes(user,TipoDeRelacion.RECEPTOR)
		]
	}
	
	def enviarMensajeAAmigo(Usuario quienEnvia , Usuario quienRecibe , String mensajeAEnviar) {
		GraphServiceRunner::run[
			var mail = new Mail(quienEnvia.nombreDeUsuario,quienRecibe.nombreDeUsuario,"Servicio de correo RenFriends",mensajeAEnviar)
			createHome(it).envioDeMensaje(quienEnvia,mail,quienRecibe)
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
	
	def eliminarUsuario(Usuario usuario) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(usuario)
			null
		]
	}
	

	def amigosDeAmigos(Usuario usuario){
		GraphServiceRunner::run[
			createHome(it).connectedComponent(usuario)
		]
	}
	
	def eliminarMail(Mail m){
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(m)
			null
		]
	}
	
	def borrarMails(){
		GraphServiceRunner::run[
			createHome(it).borrarMails()
			null
		]
	}
	
	def borrarUsuarios(){
		GraphServiceRunner::run[
			createHome(it).borrarUsuarios()
			null
		]
	}	
	
	def drop() {
		this.borrarMails
		this.borrarUsuarios
	}
	
	def estaEnSuCirculoDeAmigosDeAmigos(Usuario usuarioAVerificar, Usuario uno) {
		var amigosDeAmigos = this.amigosDeAmigos(usuarioAVerificar)
		return amigosDeAmigos.contains(uno)
	}
	
}
