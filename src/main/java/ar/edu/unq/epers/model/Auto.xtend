package ar.edu.unq.epers.model

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Auto {
	String marca
	String modelo
	Integer año
	String patente
	Double costoBase
	Categoria categoria
	
	//Debe estar ordenado
	List<Reserva> reservas = newArrayList()
	Ubicacion ubicacionInicial

	def getUbicacion(){
		this.ubicacionParaDia(new Date());
	}
	
	def ubicacionParaDia(Date unDia){
		val encontrado = reservas.findFirst [ it.fin.compareTo(unDia) <= 0 ]
		if(encontrado != null){
			return encontrado.destino
		}else{
			return ubicacionInicial
		}
	}
	
	def agregarReserva(Reserva reserva){
		reservas.add(reserva)
		reservas.sortInplaceBy[inicio]
	}
	
}
