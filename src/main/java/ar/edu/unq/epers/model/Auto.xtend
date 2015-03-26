package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors  
class Auto {
	String marca
	String modelo
	int año
	String patente
	double costo
	Categoria categoria
	Ubicacion ubicacion
	
	
	def double costoTotal(){
		// TODO
		// Esto depende de la forma que tomamos el porcentaje
		// las opciones que me imagino son:
		// 									1.3
		//									30
		//									0.3
		// Depende de como lo tomemos hacemos el calculo
		return costo * categoria.porcentaje
	}
}