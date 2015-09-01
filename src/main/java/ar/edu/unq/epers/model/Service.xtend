package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.extensions.MailService
import java.util.Collection

@Accessors
class Service {
	
	MailService mS;
	UserDao udao;
	String email;
	
	
	def registrarUsuario(Usuario nuevoUsuario)throws UsuarioYaExisteException{

			
			var u= udao.getUsuario(nuevoUsuario);
			if(u!=null && !u.validez){
				nuevoUsuario.validez=false;
				nuevoUsuario.codigo=new Integer(nuevoUsuario.hashCode()).toString();
				udao.save(nuevoUsuario);
			}
	}
		
	
	
	def validarCuenta(String codigoValidacion)throws ValidacionException{
		
	}
	
	def Usuario ingresarUsuario(String userName, String password)
	throws UsuarioNoExisteException{
		
	}
	
	def cambiarPassword(String userName, String password, String nuevaPassword)
	throws NuevaPasswordInvalida{
		try{
			udao.cambiarPassword(userName,password,nuevaPassword,this);
		}catch(NuevaPasswordInvalida e){
			throw e;
		}
	}
}