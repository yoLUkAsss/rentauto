package ar.edu.unq.epers.homes


import org.junit.Before
import org.junit.Test

import static org.mockito.Mockito.*
import static org.junit.Assert.*
import ar.edu.unq.epers.services.AutoService
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Assert
import ar.edu.unq.epers.model.Auto
import org.mockito.Mock

class AutoHomeTest {
	
	AutoHome SUT
	
	@Before
	def void startUp(){
		SUT = new AutoHome
	}
	
	@Test
	def testSinAutosCargadosInicialmente(){
		Assert.assertEquals(0,SUT.obtenerTodosLosAutos.size)
	}
	
	@Test
	def testObtenerTodosLosAutosFunciona() {
		var Auto unAuto = mock(typeof(Auto))
		SUT.save(unAuto)
		Assert.assertEquals(1,SUT.obtenerTodosLosAutos.size)
	}
	
	
}