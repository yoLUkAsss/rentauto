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

			
			var u= udao.getUsuario(nuevoUsuario.nombreDeUsuario);
			nuevoUsuario.validez=false;
			nuevoUsuario.codigo=new Integer(nuevoUsuario.hashCode()).toString()
			if(u!=null && !u.validez){
				udao.update(nuevoUsuario)
				envMail(nuevoUsuario)
			}else{
				if(u==null){
					udao.save(nuevoUsuario)
					envMail(nuevoUsuario)
				}else{
					throw new UsuarioYaExisteException
				}
			}
	}

	def private envMail(Usuario nuevoUsuario){
		mS.enviarMail(new Mail(email,nuevoUsuario.email,"verificacion de cuenta requerida","debe activar la cuenta con este codigo: " + nuevoUsuario.codigo))
	}
		
	
	
	def validarCuenta(String codigoValidacion)throws ValidacionException{
		var user = this.udao.getUsuarioPorCodigoDeValidacion(codigoValidacion);
		if (user==null) {
			throw new ValidacionException;
		} else {
			user.validar();
			this.udao.save(user);
		}
	}
	
	def Usuario ingresarUsuario(String userName, String password)
	throws UsuarioNoExisteException{
		
		var Usuario user= udao.getUsuario(userName);
		if(user==null)
		{
			throw new UsuarioNoExisteException
		}
		else{
			if(password.equals(user.password) && user.validez){
			return user;
			}else return null;
		}
		
		
	}
	
	def cambiarPassword(String userName, String password, String nuevaPassword)
	throws NuevaPasswordInvalida{
		//inviariante userNameSiempreCorrecto?? o tiramos exception de pas, o username invalid?
		var u = udao.getUsuario(userName)
		if(u!=null && u.passValida(password) && u.password !=nuevaPassword){
			u.password=nuevaPassword
			udao.update(u);		
		}else{
			throw new NuevaPasswordInvalida
		}
	}
	
	
}