package ar.edu.unq.epers.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Ubicacion {
	Integer id
	String nombre

	
	new(){}

	new(String nombre){
		this.nombre = nombre
	}
	
	override equals(Object o) {
		if (o != null && o instanceof Ubicacion){
			return this.nombre.equals((o as Ubicacion).nombre)
		}
		return false
	}
}
 
@Accessors 
class UbicacionVirtual extends Ubicacion{
	List<Ubicacion> ubicaciones
}
 