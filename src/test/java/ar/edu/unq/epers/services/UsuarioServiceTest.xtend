package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class UsuarioServiceTest {
	
	Usuario usuario
	UsuarioService service
	
	@Before
	def void init(){
		usuario= new Usuario()
		service= new UsuarioService()
		service.crearUsuario("Homero","Simpson","Homerito","amanteDeLaComida@gmail.com","10/05/1991",true,"2345","1234")
	}
	
	
	@Test
	def testConsultoSiElUsuarioEsElQueGuarde(){
		
		var usuario=service.consultarUsuario(1)
	    Assert.assertEquals("Homero", usuario.getNombre());
	    Assert.assertEquals("Simpson", usuario.getApellido())
	    Assert.assertEquals("Homerito", usuario.getNombreDeUsuario())
	   
	
		
	}
	
	
	
	
}