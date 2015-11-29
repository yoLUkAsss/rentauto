package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import java.util.List
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Frozen
import com.datastax.driver.mapping.annotations.Table
import com.datastax.driver.mapping.annotations.Column
import com.datastax.driver.mapping.annotations.Accessor
import com.datastax.driver.mapping.annotations.FrozenValue

/**
 * Objeto Key-Value para el uso del servicio de Cache utilizando la tecnologia de Cassandra (Datastax)
 * 
 * Las claves son dia y ubicacion
 * El valor es una lista de autos
 */
@Accessors
@Table (keyspace = "autosPorDia", name = "autosCacheados")
class BusquedaPorDiaReserva {
	
	@Column(name = "dia")
 	@PartitionKey(0)
 	Date dia
 	@Column(name = "ubicacion")
	@PartitionKey(1)
	String ubicacion
	@Column(name = "autos")
	@FrozenValue
	List<Auto> autos
	
	new (Date dia, String ubicacion, List<Auto> autos){
		this.dia = dia
		this.ubicacion = ubicacion
		this.autos = autos
	}
	
	def agregarAuto(Auto a){
		this.autos.add(a)
	}
	
	def borrarAuto(Auto a){
		this.autos.remove(a)
	}
}
