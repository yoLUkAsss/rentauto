package ar.edu.unq.epers.model

import org.junit.Test

import static org.junit.Assert.*

class UbicacionPorFechaTest extends AbstractTest {
		
	@Test
	def ubicacionReservasVacias(){
		assertEquals(auto.ubicacionInicial, auto.ubicacion)
	}
	
	@Test
	def ubicacionUnaReserva(){
		val reserva = new Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
		]
		auto.agregarReserva(reserva)
		
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,02,28)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,01)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,02)))
		
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,05)))
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,06)))
	}


	@Test
	def ubicacionDosReservas(){
		auto.agregarReserva(new Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
		])

		auto.agregarReserva(new Reserva => [
			origen = aeroparque
			destino = retiro
			inicio = nuevaFecha(2015,03,06)
			fin = nuevaFecha(2015,03,10)
			it.auto = this.auto
		])
		
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,02,28)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,1)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,2)))
		
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,5)))
		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,6)))

		assertEquals(aeroparque, auto.ubicacionParaDia(nuevaFecha(2015,03,9)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,11)))
		assertEquals(retiro, auto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	}
	
}