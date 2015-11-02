package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class RenFriendsServiceTest {
	
	
	RenFriendsService SUT
	
	Usuario user1; Usuario user2; Usuario user3; Usuario user4
	
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
		
		SUT.agregarNuevoUsuario(user1)
		SUT.agregarNuevoUsuario(user2w)
		SUT.agregarNuevoUsuario(user3)
		SUT.agregarNuevoUsuario(user4)
	}
	
	@Test
	def void test_al_relacionar_dos_usuarios_se_crea_la_amistad_inversa() {
		SUT.crearAmistad(user2,user4)
		
		Assert.assertTrue(SUT.misAmigosDirectos(user2).contains(user4))
	}
}