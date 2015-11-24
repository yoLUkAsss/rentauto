package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import java.util.List
import com.datastax.driver.mapping.annotations.PartitionKey
import org.joda.time.DateTime
import com.datastax.driver.mapping.annotations.Frozen
import com.datastax.driver.mapping.annotations.Table

@Accessors
@Table (name = "BusquedaPorDiaReserva")
class BusquedaPorDiaReserva {
	
	
	@PartitionKey
	Date dia
	@PartitionKey
	Ubicacion ubicacion
	@Frozen
	List<Auto> autos
	
	new (Date d, Ubicacion ubicacion, List<Auto> autos){
		dia = d
		this.ubicacion = ubicacion
		this.autos=autos
	}
	
	def agregarAuto(Auto a){
		this.autos.add(a)
	}
	
	def borrarAuto(Auto a){
		this.autos.remove(a)
	}
}
