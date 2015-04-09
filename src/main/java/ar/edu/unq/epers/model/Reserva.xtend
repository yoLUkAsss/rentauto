package ar.edu.unq.epers.model

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Reserva {
	Ubicacion origen
	Ubicacion destino
	Date inicio
	Date fin
	Auto auto
	Usuario usuario
}

@Accessors 
class ReservaEmpresarial {
	String cuil
	String nombreContacto
	String cargoContacto
	String
}