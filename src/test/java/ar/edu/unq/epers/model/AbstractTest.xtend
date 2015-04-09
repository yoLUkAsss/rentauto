package ar.edu.unq.epers.model

import java.util.Calendar
import org.junit.Before

class AbstractTest {
	protected Auto auto
	protected Categoria categoriaFamiliar
	protected Ubicacion retiro
	protected Ubicacion aeroparque

	@Before
	def void setUp() {
		categoriaFamiliar = new Familiar
		retiro = new Ubicacion("Retiro")
		aeroparque = new Ubicacion("Aeroparque")
		auto = new Auto("Peugeot", "505", 1990, "XXX123", categoriaFamiliar, 100D, retiro)
	}
	
	def nuevaFecha(int year, int month, int day){
		val cal = Calendar.instance
		cal.set(year,month - 1,day,0,0,0)
		cal.set(Calendar.MILLISECOND,0)
		cal.time
	}
	
}
