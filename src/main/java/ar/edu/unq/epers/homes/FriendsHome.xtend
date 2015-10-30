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

class FriendsHome {
	
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}
	
	private def personLabel() {
		DynamicLabel.label("Usuario")
	}
	
	def crearNodo(Usuario nuevoUsuario) {
		val node = this.graph.createNode(personLabel)
		node.setProperty("nombre", nuevoUsuario.nombre)
		node.setProperty("nombreDeUsuario", nuevoUsuario.nombreDeUsuario)
		node.setProperty("apellido", nuevoUsuario.apellido)
	}
	
	def eliminarNodo(Usuario aEliminar) {
		val nodo = this.getNodo(aEliminar)
		nodo.relationships.forEach[delete]
		nodo.delete
	}
	
	def getNodo(Usuario buscado) {
		this.getNodo(buscado.nombreDeUsuario)
	}
	
	def getNodo(String username) {
		this.graph.findNodes(personLabel, "nombreDeUsuario", username).head
	}
	
	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
	
	private def toUsuario(Node nodo) {
		new Usuario => [
			nombreDeUsuario = nodo.getProperty("nombreDeUsuario") as String
			nombre = nodo.getProperty("nombre") as String
			apellido = nodo.getProperty("apellido") as String
		]
	}
	
	def agregarNuevaRelacion(Usuario usuario1, Usuario usuario2) {
		var nodo1 = this.getNodo(usuario1)
		var nodo2 = this.getNodo(usuario2)
		nodo1.createRelationshipTo(nodo2,TipoDeRelacion.AMIGO)
		nodo2.createRelationshipTo(nodo1,TipoDeRelacion.AMIGO)
	}
	
	def buscarRelacionados(Usuario usuario) {
		var nodo = this.getNodo(usuario)
		var nodosBuscados = nodosRelacionados(nodo,TipoDeRelacion.AMIGO,Direction.BOTH)
		nodosBuscados.map[toUsuario].toSet
	}
	
	def buscarAmigo(String usuario) {
		var nodo = this.getNodo(usuario)
		toUsuario(nodo)
	}
	
	
	
}