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

class ServicioDeReservaDeAutosTest {
	
	ReservaDeAutosService SUT
	Ubicacion lanus;Ubicacion berazategui
	Categoria familiar;Categoria deportivo;Categoria familiar2;Categoria familiar3;
	AutoService servicioAutos
	
	@Before
	def void startUp() {
		lanus = new Ubicacion("Lanus")
		berazategui = new Ubicacion("Berazategui")
		familiar = new Familiar("Familiar")
		deportivo = new Deportivo("Deportivo")
		familiar2 = new Familiar("Familiar")
		familiar3 = new Familiar("Familiar")
		servicioAutos = new AutoService
		servicioAutos.crearAuto("Peugeot","504",1998,"456ART",deportivo,10.000,lanus)
		servicioAutos.crearAuto("Fiat","Palio",2001,"982DJS",familiar,12.500,berazategui)
		servicioAutos.crearAuto("Ferrari","cualquiera",2005,"3727HYT3",deportivo,270.000,lanus)
		servicioAutos.crearAuto("Ferrari","cualquiera",2015,"3727HZT3",deportivo,15000.000,berazategui)
		SUT = new ReservaDeAutosService
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
	
	@Test
	def void testConsultaDeReserva(){
		var Date fechaInicio = Calendar.instance.time
		var Calendar cal = Calendar.instance
		cal.setTime(fechaInicio)
		cal.add(Calendar.DATE, 10)
		var Date fechaFin = cal.time
		var Auto ferrari1= new Auto("Ferrari","cualquiera",2005,"3727HYT3",deportivo,270.000,lanus)
		var Auto ferrari2= new Auto("Ferrari","cualquiera",2015,"3727HYT3",deportivo,15000.000,berazategui)
		var Auto peudgeot = new Auto("Peugeot","504",1998,"456ART",deportivo,10.000,lanus)
		
		var resultado = SUT.consultaDeReserva(lanus,berazategui,fechaInicio,fechaFin,deportivo)
		Assert.assertTrue(resultado.contains(ferrari1) && resultado.contains(peudgeot))
	}
	
	
}