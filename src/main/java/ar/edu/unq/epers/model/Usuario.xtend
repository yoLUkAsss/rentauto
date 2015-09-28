package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Usuario implements IUsuario {
	
	Integer id 
	String nombre;
	String apellido;
	String nombreDeUsuario;
	String email;
	String fechaDeNacimiento;
	String password;
	Boolean validez;
	String codigo;
	List<Reserva> reservas = newArrayList()
	
	
	new(){}
	
	new(String nombre,
	String apellido,
	String nombreDeUsuario,
	String email,
	String fechaDeNacimiento,
	Boolean validez,
	String codigo,
	String password){
		this.nombre=nombre;
		this.apellido=apellido;
		this.nombreDeUsuario=nombreDeUsuario;
		this.email=email;
		this.fechaDeNacimiento=fechaDeNacimiento;
		this.password=password;
		this.validez=validez;
		this.codigo=codigo;
	}
	val esIngresoValido =[
		String password |
		 this.passValida(password) && this.validez
	]
	
	def validar() {
		this.validez=true;
	}
	
	def Boolean passValida(String pass){
		return this.password.equals(pass)
	}
	
	def ingresoValido(String password){
		return esIngresoValido.apply(password)
	}
	
	override equals(Object o){
		if(o!=null && o.class==this.class){
			var Usuario n = o as Usuario;
			return this.nombreDeUsuario == n.nombreDeUsuario
		}else{
			return false;
		}
	}
	
	override agregarReserva(Reserva unaReserva) {
		unaReserva.validar
		reservas.add(unaReserva)
		reservas.sortInplaceBy[inicio]	
	}
	
	override getReservas() {
		
		reservas
	}
	
}