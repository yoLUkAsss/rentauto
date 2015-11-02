package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Ubicacion
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class AutoServiceTest {
	
    Categoria	deportivo 
	Ubicacion   urlin 
	Ubicacion   quilmes
	AutoService servicioAutos
	Auto autoFiat
	 
	@Before
	def void setUp(){
		deportivo = new Deportivo("Deportivo")
		urlin = new Ubicacion("urlingam")
		quilmes= new Ubicacion ("quilmes")
		servicioAutos = new AutoService
		autoFiat =servicioAutos.crearAuto("fiat","98",2001, "mgx 123",deportivo,12.3,urlin)
	}
   
   /**
    * Este test verifica que los datos del auto guardado son correctos
    * 
    */
 
	@Test
	def consultar(){
		var auto = new AutoService().consultarAuto(1);
		Assert.assertEquals("fiat", auto.getMarca());
		Assert.assertEquals("mgx 123", auto.getPatente());
		Assert.assertEquals("98", auto.getModelo());
		Assert.assertEquals(2001, auto.getAnio());
		Assert.assertEquals(deportivo.id,auto.categoria.id)
		Assert.assertEquals(urlin.id,auto.ubicacionInicial.id)
	}
	
	
	/**
	 * Este test verifica que cuando cambio la ubicacion del auto,se guarda correctamente 
	 */
	@Test
	def modificarUbicacion(){
		
		var auto= new AutoService().modificarUbicacion(autoFiat.id,quilmes);
		Assert.assertEquals(quilmes.id,auto.ubicacionInicial.id)
		
		
	}
	
	
	@After
	def void limpiarYFinalizarConLosTests() {
		SessionManager::closeSession
	}
	
  
  
}