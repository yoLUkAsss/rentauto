package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.mongoDB.Calificacion
import ar.edu.unq.epers.model.mongoDB.Visibilidad
import ar.edu.unq.epers.model.mongoDB.AutoCalificado
import ar.edu.unq.epers.mongodb.SistemDB
import org.mongojack.DBQuery
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CalificacionDeAutos {
	
	RenFriendsService servicioDeAmigos
	
	def calificarAuto(Usuario usuarioQueCalifica,Auto autoCalificado,Calificacion calificacion,String message,Visibilidad visibility){
		val homeAuto = SistemDB.instance().collection(AutoCalificado);
		val calificacionAGuardar = new AutoCalificado(usuarioQueCalifica.nombreDeUsuario,autoCalificado.patente,autoCalificado.categoria,calificacion,message,visibility)
		homeAuto.insert(calificacionAGuardar)
	}
	
	def verPerfil(Usuario usuarioQueQuiereVer , Usuario usuarioBuscado){
		val homeAuto = SistemDB.instance().collection(AutoCalificado);
		if (usuarioQueQuiereVer.equals(usuarioBuscado))
			return homeAuto.mongoCollection.find(DBQuery.is("username", usuarioQueQuiereVer.nombreDeUsuario))
		if (servicioDeAmigos.sonAmigos(usuarioBuscado,usuarioQueQuiereVer))
			return homeAuto.mongoCollection.find(DBQuery.in("visibilidad", Visibilidad.SOLOAMIGOS,Visibilidad.AMIGOSDEAMIGOS,Visibilidad.PUBLICO).and(DBQuery.is("username",usuarioBuscado.nombreDeUsuario)))
		if(servicioDeAmigos.estaEnSuCirculoDeAmigosDeAmigos(usuarioBuscado,usuarioQueQuiereVer))
			return homeAuto.mongoCollection.find(DBQuery.in("visibilidad", Visibilidad.AMIGOSDEAMIGOS,Visibilidad.PUBLICO).and(DBQuery.is("username",usuarioBuscado.nombreDeUsuario)))
		return homeAuto.mongoCollection.find(DBQuery.is("visibilidad",Visibilidad.PUBLICO).and(DBQuery.is("username",usuarioBuscado.nombreDeUsuario)))
	}

	def borrarTodo(){
		val homeAuto = SistemDB.instance().collection(AutoCalificado);
		homeAuto.mongoCollection.drop
		servicioDeAmigos.drop
	}
	
	def getAutosCalificados() {
		val homeAuto = SistemDB.instance().collection(AutoCalificado);
		val autosCalificados = homeAuto.mongoCollection.find();
		return autosCalificados
	}
	
	def getAutosCalificadosPorPatente(String patente) {
		val homeAuto = SistemDB.instance().collection(AutoCalificado);
		val autosCalificados = homeAuto.mongoCollection.find(DBQuery.is("patente", patente));
		return autosCalificados
	}
	
}