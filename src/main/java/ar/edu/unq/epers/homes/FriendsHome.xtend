package ar.edu.unq.epers.homes

import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.DynamicLabel
import ar.edu.unq.epers.model.TipoDeRelacion
import org.neo4j.graphdb.Node
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType
import ar.edu.unq.epers.model.Mail
import org.neo4j.graphdb.traversal.*;
import org.neo4j.graphdb.traversal.Uniqueness
import org.neo4j.kernel.Traversal

class FriendsHome {
	
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}
	
	private def personLabel() {
		DynamicLabel.label("Usuario")
	}
	private def mensajeLabel(){
		DynamicLabel.label("Mail")
	}
	
	def crearNodo(Usuario nuevoUsuario) {
		val node = this.graph.createNode(personLabel)
		node.setProperty("nombre", nuevoUsuario.nombre)
		node.setProperty("nombreDeUsuario", nuevoUsuario.nombreDeUsuario)
		node.setProperty("apellido", nuevoUsuario.apellido)
		return node
	}
	
	def eliminarNodo(Usuario aEliminar) {
		val nodo = this.getNodo(aEliminar)
		eliminarTodo(nodo)
	}
	
	def crearNodo(Mail nuevoMensaje) {
		val node = this.graph.createNode(mensajeLabel)
		node.setProperty("from",nuevoMensaje.from)
		node.setProperty("to",nuevoMensaje.to)
		node.setProperty("subject",nuevoMensaje.subject)
		node.setProperty("body",nuevoMensaje.body)
		node.setProperty("codigo",nuevoMensaje.codigo)
		return node
	}
	
	def eliminarNodo(Mail aEliminar) {
		val nodo = this.getNodo(aEliminar)
		eliminarTodo(nodo)
	}
	
	def getNodo(Usuario buscado) {
		this.getNodo(buscado.nombreDeUsuario)
	}
	
	def getNodo(String username) {
		this.graph.findNodes(personLabel, "nombreDeUsuario", username).head
	}
	
	def getNodo(Mail buscado) {
		this.getNodo(buscado.codigo)
	}
	
	def getNodo(Integer codigo) {
		this.graph.findNodes(personLabel, "codigo", codigo).head
	}
	
	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		print("LLEGUE ACA")
		var values = nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
		print(values)
	}
	
	private def toUsuario(Node nodo) {
		new Usuario => [
			nombreDeUsuario = nodo.getProperty("nombreDeUsuario") as String
			nombre = nodo.getProperty("nombre") as String
			apellido = nodo.getProperty("apellido") as String
		]
	}
	
	private def toMail(Node nodo) {
		new Mail => [
			from = nodo.getProperty("from") as String
			to = nodo.getProperty("to") as String
			subject = nodo.getProperty("subject") as String
			body = nodo.getProperty("body") as String
			codigo = nodo.getProperty("codigo") as Integer
		]
	}
	
	//UTILIDADES GENERALES
	def agregarNuevaRelacion(Usuario usuario1, Usuario usuario2) {
		var nodo1 = this.getNodo(usuario1)
		var nodo2 = this.getNodo(usuario2)
		nodo1.createRelationshipTo(nodo2,TipoDeRelacion.AMIGO)
		nodo2.createRelationshipTo(nodo1,TipoDeRelacion.AMIGO)
	}
	
	def buscarRelacionados(Usuario usuario) {
		var nodo = this.getNodo(usuario)
		var nodosBuscados = nodosRelacionados(nodo,TipoDeRelacion.AMIGO,Direction.OUTGOING)
		nodosBuscados.map[toUsuario].toSet
	}
	
	def envioDeMensaje(Usuario quienEnvia , Mail aEnviar, Usuario usuarioQueRecibe){
		var emisor = this.getNodo(quienEnvia)
		var mensaje = crearNodo(aEnviar)
		var receptor = this.getNodo(usuarioQueRecibe)
		
		emisor.createRelationshipTo(mensaje,TipoDeRelacion.EMISOR)
		receptor.createRelationshipTo(mensaje,TipoDeRelacion.RECEPTOR)
	}
	
	def buscarMensajes(Usuario usuario,TipoDeRelacion tipo) {
		var nodo = this.getNodo(usuario)
		var nodosBuscados = nodosRelacionados(nodo,tipo,Direction.BOTH)
		nodosBuscados.map[toMail].toSet
	}
	
	def connectedComponent(Usuario usuario) {
		var node = getNodo(usuario)
		var TraversalDescription traversalDescription = this.graph.traversalDescription()
            .depthFirst()
            .relationships(TipoDeRelacion.AMIGO, Direction.OUTGOING)
            .uniqueness(Uniqueness.NODE_GLOBAL);

    	traversalDescription.traverse(node).nodes().map[toUsuario].toSet;
	}
	
	def borrarMails() {
		var aborrar= this.graph.findNodes(mensajeLabel).toSet
		aborrar.forEach[eliminarTodo(it)]
	}
	
	def eliminarTodo(Node nodo){
		nodo.relationships.forEach[delete]
		nodo.delete
	}
	
}