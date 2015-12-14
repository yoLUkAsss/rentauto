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
import ar.edu.unq.epers.cassandra.CachedCar
import javax.persistence.Transient

/**
 * Objeto Key-Value para el uso del servicio de Cache utilizando la tecnologia de Cassandra (Datastax)
 * 
 * Las claves son dia y ubicacion
 * El valor es una lista de autos
 */
@Accessors
@Table (keyspace = "autosPorDia", name = "autosCacheados")
class BusquedaPorDiaReserva {
	
	@PartitionKey(0)
	public String ubicacion
 	@PartitionKey(1)
	@Column(name = "dia")
 	public Date dia
	@Column(name = "autos")
	@Frozen("list<frozen <cachedcar>>")
	public List<CachedCar> autos
	
	new(){}
	
	new (Date dia, String ubicacion, List<CachedCar> autos){
		this.dia = dia
		this.ubicacion = ubicacion
		this.autos = autos
	}
	
	def agregarAuto(CachedCar a){
//		this.autos.add(a)
	}
	
	
	
	def borrarAuto(CachedCar a){
//		this.autos.remove(a)
	}
}
