package ar.edu.unq.epers.cassandra

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT
import com.datastax.driver.mapping.annotations.Field

@UDT(name="autosPorDia.cachedcars")
@Accessors
class CachedCar {
	@Field(name = "patente")
	String patente
	@Field(name = "categoria")
	String categoria
	@Field(name = "marca")
	String marca
	@Field(name = "modelo")
	String modelo
	
	new(){}
	
	new(String patente, String categoria, String marca, String modelo){
		this.patente = patente
		this.categoria = categoria
		this.marca = marca
		this.modelo = modelo
	}
	
	
}