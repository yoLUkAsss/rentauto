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
import org.junit.After

class AutoHomeTest {
	
	AutoHome SUT
	Deportivo deportivo
	Ubicacion urlin
	Ubicacion quilmes
	@Before
	def void startUp(){
		SUT = new AutoHome
		deportivo = new Deportivo("Deportivo")
		urlin = new Ubicacion("urlingam")
		quilmes= new Ubicacion ("quilmes")
	}
	
	@Test
	def testSinAutosCargadosInicialmente(){
		SessionManager::runInSession[|
		Assert.assertEquals(0,SUT.obtenerTodosLosAutos.size)
		null
		]
		Assert.assertTrue(true)
	}
	
	@Test
	def testObtenerTodosLosAutosFunciona() {
		SessionManager::runInSession[|
			var Auto unAuto = new Auto("fiat","98",2001, "mgx 123",deportivo,12.3,urlin)
			SUT.save(unAuto)
			Assert.assertEquals(1,SUT.obtenerTodosLosAutos.size)
			unAuto
		]
		Assert.assertTrue(true)
		
	}
	
	@After
	def void teardown(){
		SessionManager::closeSession
	}
	
	
}