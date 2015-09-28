package ar.edu.unq.epers.services

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.homes.AutoHome
import java.util.Date
import java.util.Calendar
import static ar.edu.unq.epers.extensions.DateExtensions.*
import ar.edu.unq.epers.model.Usuario

class ServicioDeReservaDeAutosTest {
	
	ReservaDeAutosService SUT
	Ubicacion lanus;Ubicacion berazategui
	Categoria familiar;Categoria deportivo
	AutoService servicioAutos
	Auto auto
	Usuario usuario
	
	
	
	@Before
	def void startUp() {
		
		lanus = new Ubicacion("Lanus")
		berazategui = new Ubicacion("Berazategui")
		familiar = new Familiar
		deportivo = new Deportivo
		servicioAutos = new AutoService
		servicioAutos.crearAuto("Peugeot","504",1998,"456ART",familiar,10.000,lanus)
		servicioAutos.crearAuto("Fiat","Palio",2001,"982DJS",familiar,12.500,berazategui)
		servicioAutos.crearAuto("Ferrari","cualquiera",2005,"3727HYT3",deportivo,270.000,lanus)
		SUT = new ReservaDeAutosService
		auto= new Auto("Peugeot","504",2000,"587ARJ",familiar,10.000,lanus)
		usuario= new Usuario()
	}
	
	/**
	 * Este test verifica que al no haber reservas hechas aun, y solo teniendo 3 autos
	 * 2 de ellos cumplen el hecho de estar disponibles para cualquier dia, en la ubicacion "lanus"
	 */
	@Test
	def void testVerificarAutosDisponiblesEsCorrecto() {
		var Date septiembre24 = Calendar.instance.time
		var resultado = SUT.autosDisponibles(lanus,septiembre24)
		
		Assert.assertEquals(2,resultado)
	}
	
	
	
	
	
	
	
}