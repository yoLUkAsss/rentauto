package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.extensions.MailService
import java.util.Collection

@Accessors
class Service {
	
	MailService mS;
	Collection<Usuario> users;
	
	def registrarUsuario(Usuario nuevoUsuario)throws UsuarioYaExisteException{
		
	}
	
	def validarCuenta(String codigoValidacion)throws ValidacionException{
		
	}
	
	def Usuario ingresarUsuario(String userName, String password)
	throws UsuarioNoExisteException{
		
	}
	
	def cambiarPassword(String userName, String password, String nuevaPassword)
	throws NuevaPasswordInvalida{
		
	}
}