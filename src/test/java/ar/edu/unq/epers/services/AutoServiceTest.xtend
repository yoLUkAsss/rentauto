package ar.edu.unq.epers.services

import org.junit.Before
import org.junit.Test
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Assert
import ar.edu.unq.epers.model.Categoria

class AutoServiceTest {
	
	Categoria depor = new Deportivo()
	Ubicacion urlin = new Ubicacion("urlingam")
	
	@Before
	def void startUp(){
		new AutoService().crearAuto("fiat","98",2001, "mgx 123",depor,12.3,urlin);
	}
	
	@Test
	def consultar(){
		var auto = new AutoService().consultarAuto(1);
		Assert.assertEquals("fiat", auto.getMarca());
		Assert.assertEquals("mgx 123", auto.getPatente());
		Assert.assertEquals("98", auto.getModelo());
		Assert.assertEquals(2001, auto.getAnio());
		Assert.assertEquals(depor,auto.categoria)
		Assert.assertEquals(urlin,auto.ubicacionInicial)
	}
	
}