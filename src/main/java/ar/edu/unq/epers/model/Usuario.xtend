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

	
	new(String nombre,
	String apellido,
	String nombreDeUsuario,
	String email,
	String fechaDeNacimiento,
	String password){
		this.nombre=nombre;
		this.apellido=apellido;
		this.nombreDeUsuario=nombreDeUsuario;
		this.email=email;
		this.fechaDeNacimiento=fechaDeNacimiento;
		this.password=password;
	}
	
	
	
}