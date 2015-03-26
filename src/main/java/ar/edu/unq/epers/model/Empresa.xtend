package ar.edu.unq.epers.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Empresa {
	
	List<Auto> autos
	Ubicacion ubicacion
	
}