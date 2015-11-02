package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.junit.After
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException

class RenFriendsServiceTest {
	
	
	RenFriendsService SUT
	
	Usuario user1; Usuario user2; Usuario user3; Usuario user4; Usuario user5
	
	@Before
	def void init(){
		SUT = new RenFriendsService
		user1 = new Usuario => [
			nombreDeUsuario = "xPeke"
			nombre = "Pedro"
			apellido = "Gonzalez"
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
			nombreDeUsuario = "patata"
			nombre = "Ricardo"
			apellido = "Mercado"
		]
		
		
		
		SUT.agregarNuevoUsuario(user1)
		SUT.agregarNuevoUsuario(user2)
		SUT.agregarNuevoUsuario(user3)
		SUT.agregarNuevoUsuario(user4)
	
	}
	
	@After
	def void after(){
		
	   SUT.eliminarUsuario(user1)
	   SUT.eliminarUsuario(user2)
	   SUT.eliminarUsuario(user3)
	   SUT.eliminarUsuario(user4)
	}
	
	
	@Test
	def void test_al_relacionar_dos_usuarios_se_crea_la_amistad_inversa() {
		SUT.crearAmistad(user2,user4)
		
		
		Assert.assertEquals("Pichichu",SUT.misAmigosDirectos(user2).get(0).nombreDeUsuario)
	}
	
	@Test
	def void consultarAmigosDelUsuario1(){
		SUT.crearAmistad(user1,user2)
		SUT.crearAmistad(user1,user4)
		SUT.crearAmistad(user1,user4)
        val amigos= SUT.misAmigosDirectos(user1)
		Assert.assertEquals(3,amigos.length)
		
	}
	@Test(expected = UsuarioNoExisteException)
	def void soloSePuedoAgregarAmigosQueEstanRegistrados(){
		
		SUT.crearAmistad(user1,user2)
		SUT.crearAmistad(user1,user4)
		SUT.crearAmistad(user1,user5)
        val amigos= SUT.misAmigosDirectos(user1)
		Assert.assertEquals(2,amigos.length)
		
		
		
	}
	
}