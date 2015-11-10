package ar.edu.unq.epers.services

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.mongoDB.Calificacion
import ar.edu.unq.epers.model.mongoDB.Visibilidad

class CalificacionDeAutoServiceTest {
	
	CalificacionDeAutos sut;
	Usuario spyUsuario;
	Auto spyAuto;
	RenFriendsService servicioAmigos
	
	Usuario user1; Usuario user2; Usuario user3; Usuario user4; Usuario user5;Usuario user6
	@Before
	def void setup(){
		sut = new CalificacionDeAutos()
		spyUsuario = new Usuario =>[
			nombreDeUsuario = "enfermito"
		]
		spyAuto = new Auto => [
			patente = "xxx111"
		]
		
		servicioAmigos = new RenFriendsService
		user1 = new Usuario => [
			nombreDeUsuario = "xPeke"
			nombre = "Enrique Cedaño"
			apellido = "Martinez"
		]
		user2 = new Usuario => [
			nombreDeUsuario = "Scarra"
			nombre = "Javier"
			apellido = "Mendoza"
		]	
		user3 = new Usuario => [
			nombreDeUsuario = "Faker"
			nombre = "Ezequiel"
			apellido = "Martinez"
		]	
		user4 = new Usuario => [
			nombreDeUsuario = "Pichichu"
			nombre = "Fernando"
			apellido = "Menendez"
		]
		user5 = new Usuario => [
			nombreDeUsuario = "sOAZ"
			nombre = "Voyshech"
			apellido = "Motul"
		]
		
		user6 = new Usuario => [
			nombreDeUsuario = "patata"
			nombre = "Ricardo"
			apellido = "Mercado"
		]
		
		
		
		servicioAmigos.agregarNuevoUsuario(user1)
		servicioAmigos.agregarNuevoUsuario(user2)
		servicioAmigos.agregarNuevoUsuario(user3)
		servicioAmigos.agregarNuevoUsuario(user4)
		servicioAmigos.agregarNuevoUsuario(user5)
		servicioAmigos.crearAmistad(user2,user4)
		servicioAmigos.crearAmistad(user4,user3)
		sut.servicioDeAmigos = servicioAmigos
	
	}
	
	@Test
	def testCalificarAuto(){
		sut.calificarAuto(spyUsuario,spyAuto,Calificacion.MALO,"#NoSql",Visibilidad.PRIVADO)
		var calificacionDeAutoEsperada = sut.getAutosCalificadosPorPatente("xxx111");
		Assert.assertEquals(calificacionDeAutoEsperada.get(0).patente,"xxx111")
		
	}
	
	@Test
	def testUsuarioPidePerfilDeAmigo(){
		sut.calificarAuto(user4,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PRIVADO)
		sut.calificarAuto(user4,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PUBLICO)
		sut.calificarAuto(user4,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.SOLOAMIGOS)
		var perfil = sut.verPerfil(user2,user4)
		
		Assert.assertEquals(perfil.size, 2)
	}
	
	@Test
	def testUsuarioPidePerfilDeNoAmigo(){
		sut.calificarAuto(user5,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PRIVADO)
		sut.calificarAuto(user5,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PUBLICO)
		sut.calificarAuto(user5,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.SOLOAMIGOS)
		var perfil = sut.verPerfil(user2,user5)
		
		Assert.assertEquals(perfil.size, 1)
	}
	
	@Test
	def testUsuarioPidePerfilDeSiMismo(){
		sut.calificarAuto(user2,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PRIVADO)
		sut.calificarAuto(user2,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PUBLICO)
		sut.calificarAuto(user2,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.SOLOAMIGOS)
		sut.calificarAuto(user2,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.AMIGOSDEAMIGOS)
		var perfil = sut.verPerfil(user2,user2)
		
		Assert.assertEquals(perfil.size, 4)
	}
	
	@Test
	def testUsuarioPidePerfilDeSiAmigoIndirecto(){
		sut.calificarAuto(user3,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PRIVADO)
		sut.calificarAuto(user3,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.PUBLICO)
		sut.calificarAuto(user3,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.SOLOAMIGOS)
		sut.calificarAuto(user3,spyAuto,Calificacion.BUENO,"Enrique",Visibilidad.AMIGOSDEAMIGOS)
		var perfil = sut.verPerfil(user2,user3)
		
		Assert.assertEquals(perfil.size, 2)
	}
	
	@After
	def void afta(){
		sut.borrarTodo()
	}
	
}