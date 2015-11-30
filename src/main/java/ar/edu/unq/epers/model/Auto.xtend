package ar.edu.unq.epers.model

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


/**
 * ALGO
 */
@Accessors
class Auto {
	
	Integer id
	String marca
	String modelo
	Integer anio
	String patente
	Double costoBase
	Categoria categoria
	
	//Debe estar ordenado
	List<Reserva> reservas = newArrayList()
	Ubicacion ubicacionInicial
	
	new(){}

	new(String marca, String modelo, Integer anio, String patente, Categoria categoria, Double costoBase, Ubicacion ubicacionInicial){
		this.marca = marca
		this.modelo = modelo
		this.anio = anio
		this.patente = patente
		this.costoBase = costoBase
		this.categoria = categoria
		this.ubicacionInicial = ubicacionInicial
		this.reservas = newArrayList
	}

	def getUbicacion(){
		this.ubicacionParaDia(new Date());
	}
	
	def isCategory(Categoria c){
		categoria.equals(c);
	}
	
	def ubicacionParaDia(Date unDia){
		val encontrado = reservas.findLast[ it.fin <= unDia ]
		if(encontrado != null){
			return encontrado.destino
		}else{
			return ubicacionInicial
		}
	}
	
	def Boolean estaLibre(Date desde, Date hasta){
		reservas.forall[ !seSuperpone(desde,hasta)]
	}
	
	def agregarReserva(Reserva reserva){
		reserva.validar
		reservas.add(reserva)
		reservas.sortInplaceBy[inicio]
	}
	
	override equals(Object o){
		if (o != null && o instanceof Auto) {
			var Auto a = o as Auto
			return this.patente.equals(a.patente)
		}
		return false;
	}
	
	def costoTotal(){
		return categoria.calcularCosto(this)
	}
	
		
	
	
}
