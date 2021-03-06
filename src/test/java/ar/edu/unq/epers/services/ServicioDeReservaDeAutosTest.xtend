package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test 

import static ar.edu.unq.epers.extensions.DateExtensions.*

class ServicioDeReservaDeAutosTest {

	ReservaDeAutosService SUT
	Usuario usuario;
	Ubicacion varela; Ubicacion laPlata
	Ubicacion lanus;Ubicacion berazategui
	Categoria familiar;Categoria deportivo;Categoria familiar2;Categoria familiar3;
	AutoService servicioAutos
	UsuarioService usuarioService
	Auto autoFord; Auto autoFerrari; Auto autoFord2; Auto autoPeudgeot; Auto autoFiat;Auto autoFerrari2;



	@Before
	def void setUp() {
		varela = new Ubicacion("Florencio Varela")
	    laPlata = new Ubicacion("La Plata")
		lanus = new Ubicacion("Lanus")
		berazategui = new Ubicacion("Berazategui")
		familiar = new Familiar("Familiar")
		deportivo = new Deportivo("Deportivo")
		familiar2 = new Familiar("Familiar")
		familiar3 = new Familiar("Familiar")

		usuarioService= new UsuarioService
		usuario =usuarioService.crearUsuario("Homero","Simpson","Homerito","amanteDeLaComidagmail.com","10/05/1991",true,"2345","1234")

		servicioAutos = new AutoService
		autoPeudgeot =servicioAutos.crearAuto("Peugeot","504",1998,"456ART",deportivo,10.000,lanus)
		autoFiat =servicioAutos.crearAuto("Fiat","Palio",2001,"982DJS",familiar,12.500,berazategui)
		autoFerrari =servicioAutos.crearAuto("Ferrari","cualquiera",2005,"3727HYT3",deportivo,270.000,lanus)
		autoFord2 =servicioAutos.crearAuto("Ford","F100",2010,"578HTM",familiar,200.000,laPlata)
		autoFord = servicioAutos.crearAuto("Ford","F100",2010,"568HTM",familiar,200.000,laPlata)
		autoFerrari2 =servicioAutos.crearAuto("Ferrari","cualquiera",2015,"3727HZT3",deportivo,15000.000,berazategui)
		SUT = new ReservaDeAutosService

	}

	/**
	 * Este test verifica que al no haber reservas hechas aun, y solo teniendo 3 autos
	 * 2 de ellos cumplen el hecho de estar disponibles para cualquier dia, en la ubicacion "lanus"
	 */
	@Test
	def void testVerificarAutosDisponiblesEsCorrecto() {
		var fecha = nuevaFecha(2015,03,05)

		var resultado = SUT.autosDisponibles(lanus,fecha)

		Assert.assertEquals(2,resultado.size)
	}
    /**
     * Este test consulta los autos disponibles para una ubicacion en un tiempo determinado
     *
     */

	@Test

	def void testConsultaDeReservaDevuelveAutoPeudgeotLikePokemon(){


		var fechaInicio = nuevaFecha(2015,03,01)
	    var fechaFin = nuevaFecha(2015,03,05)

		var resultado = SUT.consultaDeReserva(lanus,berazategui,fechaInicio,fechaFin,deportivo)
		Assert.assertTrue(resultado.contains(autoFerrari) && resultado.contains(autoPeudgeot))
	}

	/**
	 * Este test verifica que una vez hecha una reserva, el auto ya no esta disponible
	 *
	 *
	 */

	@Test
	def void testCrearReserva(){

		var inicio = nuevaFecha(2015,03,01)
	    var fin = nuevaFecha(2015,03,05)
	    SUT.crearReserva(20,laPlata,varela,inicio,fin,usuario, autoFord)
	    var resultado = SUT.consultaDeReserva(laPlata,varela,inicio,fin,familiar)

		Assert.assertFalse(resultado.contains(autoFord))

	}

	/**
	 * Se encarga de limpiar la bases de datos luego de ejecutar todos los tests
	 *
	 * @author Claudio
	 */
	@After
	def void limpiarYFinalizarConLosTests() {
		SessionManager::closeSession
	}

}
