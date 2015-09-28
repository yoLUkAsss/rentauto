package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
  
@Accessors 
abstract class Categoria {
	Integer id
	String nombre
	
	new(){}
	
	new(String nombre){
		this.nombre = nombre;
	}

	override boolean equals(Object o){
		var categoria = o as Categoria;
		return this.nombre.equals(categoria.nombre);
	}
	
	abstract def Double calcularCosto(Auto auto)
}


class Turismo extends Categoria{
	
	new(String nombre){
		super(nombre)
	}
	
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.10			
		}else{
			return auto.costoBase - 200
		}
	}
}

class Familiar extends Categoria{
	new(){}
	
	new(String nombre){
		super(nombre)
	}
	
	override calcularCosto(Auto auto) {
		return auto.costoBase + 200
	}
}

class Deportivo extends Categoria{
	new(){}
	
	new(String nombre){
		super(nombre)
	}
	
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.30			
		}else{
			return auto.costoBase * 1.20
		}
	}
}

class TodoTerreno extends Categoria{
	new(){}
	
	new(String nombre){
		super(nombre)
	}
	
	override calcularCosto(Auto auto) {
		auto.costoBase * 1.10
	}
}
