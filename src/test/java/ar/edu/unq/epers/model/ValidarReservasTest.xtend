package ar.edu.unq.epers.model

import org.junit.Test

import static org.junit.Assert.*

class ValidarReservasTest extends AbstractTest {
	@Test
	def reservaUnica() {
		auto.agregarReserva(
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])
		assertEquals(1, auto.reservas.size)
	}

	@Test
	def reservaQueNoSePisan() {
		auto.agregarReserva(
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])

		auto.agregarReserva(
			new Reserva => [
				origen = aeroparque
				destino = retiro
				inicio = nuevaFecha(2015, 03, 06)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = this.auto
			])

		assertEquals(2, auto.reservas.size)
	}

	@Test(expected=ReservaException)
	def reservaQueSePisan() {
		auto.agregarReserva(
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])

		auto.agregarReserva(
			new Reserva => [
				origen = aeroparque
				destino = retiro
				inicio = nuevaFecha(2015, 03, 04)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = this.auto
			])

		fail()
	}

	@Test(expected=ReservaException)
	def reservasSinSentido() {
		auto.agregarReserva(
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])

		auto.agregarReserva(
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 05)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = this.auto
			])

		fail()
	}

}
