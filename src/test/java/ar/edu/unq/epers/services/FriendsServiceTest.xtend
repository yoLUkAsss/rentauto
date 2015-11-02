package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.junit.After

class FriendsServiceTest {
	
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Usuario usuario4
	RenFriendsService service
	
	@Before
	def void setUp(){
         usuario1 = new Usuario => [
			nombre = "José" 
			nombreDeUsuario = "jPerez"
			apellido = "Pérez"
		];
		
		usuario2 = new Usuario => [
			nombre = "Pedro" 
			nombreDeUsuario = "pSanchez"
			apellido = "Sanchez"
		];
		usuario3 = new Usuario => [
			nombre = "María" 
			nombreDeUsuario = "MZapata"
			apellido = "Zapata"
		];
		
		usuario4 = new Usuario => [
			nombre = "Carla" 
			nombreDeUsuario = "CMorales"
			apellido = "Morales"
		];
		
		service= new RenFriendsService
		service.agregarUsuario(usuario1)
	    service.agregarUsuario(usuario2)	
		service.agregarUsuario(usuario3)
		service.agregarUsuario(usuario4)
	    service.crearAmistad(usuario1,usuario2)
	    service.crearAmistad(usuario2,usuario3)
	    service.crearAmistad(usuario1,usuario4)
	   
		
	}
	
	@After
	def void after(){
		service.eliminarUsuario(usuario1)
		service.eliminarUsuario(usuario2)
		service.eliminarUsuario(usuario3)
		service.eliminarUsuario(usuario4)
		
	}
	
	@Test
	def void consultarAmigos(){
        val amigos= service.misAmigosDirectos(usuario1)
		Assert.assertEquals(2,amigos.length)
		
	}
	
	@Test
	def void buscarUsuario(){
		val usuario=service.usuario("jPerez")
		Assert.assertEquals(usuario1,usuario)
		
		
	}
	
	
		
	
	
	
}