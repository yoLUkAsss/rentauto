package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.junit.After
import ar.edu.unq.epers.homes.FriendsHome
import ar.edu.unq.epers.model.Mail

class RenFriendsServiceTest {
	
	
	RenFriendsService SUT
	
	Usuario user1; Usuario user2; Usuario user3; Usuario user4;Usuario user5;
	
	@Before
	def void init(){
		SUT = new RenFriendsService
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
		
		SUT.agregarNuevoUsuario(user1)
		SUT.agregarNuevoUsuario(user2)
		SUT.agregarNuevoUsuario(user3)
		SUT.agregarNuevoUsuario(user4)
		SUT.agregarNuevoUsuario(user5)
	}
	
	@Test
	def void test_al_relacionar_dos_usuarios_se_crea_la_amistad_inversa() {
		SUT.crearAmistad(user2,user4)
		
		Assert.assertEquals(SUT.misAmigosDirectos(user2).get(0).nombreDeUsuario,"Pichichu")
		
	}
	
	@Test
	def void test_enviar_mail_genera_las_dos_relaciones_esperadas() {
		SUT.enviarMensajeAAmigo(user4,user3,"Hola como va?")
		Assert.assertEquals(SUT.mensajesEnviados(user4).size,1)
		Assert.assertEquals(SUT.mensajesRecibidos(user3).size,1)
		
//		(1..40).forEach[
//			init
//				SUT.enviarMensajeAAmigo(user4,user3,"Hola como va?")
//				Assert.assertEquals(SUT.mensajesEnviados(user4).size,1)
//				Assert.assertEquals(SUT.mensajesRecibidos(user3).size,1)
//			after
//		]

//		GraphServiceRunner::run[
//			var home = new FriendsHome(it)
//			var nodoUsuario = home.getNodo("Scarra")
//			println(nodoUsuario.getProperty("nombreDeUsuario"))
//			var node = home.getNodo(new Mail("","","",""))
//			println(node.getProperty("body"))
//			null
//		]
	}
	
	@Test
	def void test_amigos_de_amigos_no_devuelve_amigos_no_conexos() {
		SUT.crearAmistad(user2,user4)
		SUT.crearAmistad(user4,user3)
		SUT.crearAmistad(user1,user5)
		
		
		Assert.assertFalse(SUT.amigosDeAmigos(user3).contains(user1))
		Assert.assertFalse(SUT.amigosDeAmigos(user3).contains(user3))
	}
	
	@Test
	def void test_amigos_de_amigos_devuelve_a_TODOS_los_usuarios_de_componente_conexa() {
		SUT.crearAmistad(user2,user4)
		SUT.crearAmistad(user4,user3)
		SUT.crearAmistad(user1,user5)
		
		SUT.amigosDeAmigos(user3).forEach[println(it.nombreDeUsuario)]
		Assert.assertTrue(SUT.amigosDeAmigos(user3).contains(user2)&&SUT.amigosDeAmigos(user3).contains(user4))
	}
	
	@After
	def void after(){
		SUT.borrarMails()
		SUT.eliminarUsuario(user1)
		SUT.eliminarUsuario(user2)
		SUT.eliminarUsuario(user3)
		SUT.eliminarUsuario(user4)
		SUT.eliminarUsuario(user5)
	}
}