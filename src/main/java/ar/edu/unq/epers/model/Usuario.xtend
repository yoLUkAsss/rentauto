package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {
	
	String nombre;
	String apellido;
	String nombreDeUsuario;
	String email;
	String fechaDeNacimiento;
	String password;
	Boolean validez;
	String codigo;

	
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
	
	def validar() {
		this.validez=true;
	}
	
	def Boolean passValida(String pass){
		this.password.equals(pass)
	}
	
}