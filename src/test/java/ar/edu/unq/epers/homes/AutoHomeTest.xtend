package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Deportivo
import org.junit.Assert

import org.junit.Test
import ar.edu.unq.epers.model.Auto
import org.mockito.Mock

import org.junit.After

class AutoHomeTest {
	
	@Test
	def testSinAutosCargadosInicialmente(){
		SessionManager::runInSession[|
			Assert.assertEquals(0,(new AutoHome).obtenerTodosLosAutos.size)
			void
		]
		Assert.assertTrue(true)
	}
	
	@Test
	def testObtenerTodosLosAutosFunciona() {

		SessionManager::runInSession[| 
			
			var lanus = new Ubicacion("Lanus")
			var deportivo = new Deportivo("Deportivo")
			var Auto unAuto = new Auto("Peugeot","504",1998,"456ART",deportivo,10.000,lanus)
			(new AutoHome).save(unAuto)
			Assert.assertEquals(1 ,(new AutoHome).obtenerTodosLosAutos.size)
			void
		]
		Assert.assertTrue(true)
	}
	
	@After
	def void limpiarYFinalizarConLosTests() {
		SessionManager::closeSession
	}
}
