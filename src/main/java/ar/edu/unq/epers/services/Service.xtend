package ar.edu.unq.epers.services

import ar.edu.unq.epers.excepciones.IngresoNoValidoException
import ar.edu.unq.epers.excepciones.NuevaPasswordInvalida
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import ar.edu.unq.epers.excepciones.UsuarioYaExisteException
import ar.edu.unq.epers.excepciones.ValidacionException
import ar.edu.unq.epers.extensions.MailService
import ar.edu.unq.epers.model.Mail
import ar.edu.unq.epers.homes.UserDao
import ar.edu.unq.epers.model.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Service {

	MailService mS;
	UserDao udao;
	String email;

	def registrarUsuario(Usuario nuevoUsuario) throws UsuarioYaExisteException{

		var u = udao.getUsuarioPorUsername(nuevoUsuario.nombreDeUsuario);
		nuevoUsuario.validez = false;
		nuevoUsuario.codigo = new Integer(nuevoUsuario.hashCode()).toString()
		
		if (u!=null && u.validez)
			throw new UsuarioYaExisteException
		if (u == null) 
			udao.save(nuevoUsuario)
		else 
			udao.update(nuevoUsuario)
		envMail(nuevoUsuario)
	}
	
	def validarCuenta(String codigoValidacion) throws ValidacionException{
		var user = this.udao.getUsuarioPorCodigoDeValidacion(codigoValidacion);
		
		if (user == null)
			throw new ValidacionException
		else
			user.validar()
			this.udao.save(user)
	}

	def Usuario ingresarUsuario(String userName, String password) throws UsuarioNoExisteException{

		var Usuario user = udao.getUsuarioPorUsername(userName);
		
		if (user == null)
			throw new UsuarioNoExisteException
		if (!user.ingresoValido(password))
			throw new IngresoNoValidoException
		
		return user
		
	}

	def cambiarPassword(String userName, String password, String nuevaPassword) throws NuevaPasswordInvalida{
		// inviariante userNameSiempreCorrecto?? o tiramos exception de pas, o username invalid?
		var u = udao.getUsuarioPorUsername(userName)
		
		if (cambioValido.apply(u,password,nuevaPassword)) {
			u.password = nuevaPassword
			udao.update(u)
		}
		else 
			throw new NuevaPasswordInvalida
	}

/////////////////////
///Metodos Privados//
/////////////////////

	def private envMail(Usuario nuevoUsuario) {
		mS.enviarMail(
			new Mail(email, nuevoUsuario.email, 
					 "verificacion de cuenta requerida",
					 "debe activar la cuenta con este codigo: " + nuevoUsuario.codigo))
	}
		
	val cambioValido = [
		Usuario u , String pass , String nuevaPass | 
		u!=null && u.esIngresoValido.apply(pass) && !pass.equals(nuevaPass)
	]

}
