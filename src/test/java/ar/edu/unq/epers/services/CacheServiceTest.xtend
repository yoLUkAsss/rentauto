package ar.edu.unq.epers.services

import ar.edu.unq.epers.cassandra.CachedCar
import ar.edu.unq.epers.model.BusquedaPorDiaReserva
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import java.util.List
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static ar.edu.unq.epers.extensions.DateExtensions.*

class CacheServiceTest {
	
	
	CacheService SUT
	Date unaFecha
	Ubicacion unaUbicacion
	
	CachedCar auto1;CachedCar auto2;CachedCar auto3;CachedCar auto4;CachedCar auto5;CachedCar auto6
	List<CachedCar> algunosAutos;List<CachedCar> otroListado
	
	@Before
	def void setUp(){
		SUT = new CacheService
		unaFecha = nuevaFecha(1993,12,29)
		unaUbicacion = new Ubicacion("Avellaneda")
		auto1 = new CachedCar => [patente = "123 qwe"]
		auto2 = new CachedCar => [patente = "283 hjs"]
		auto3 = new CachedCar => [patente = "174 kjs"]
		algunosAutos = newArrayList
		algunosAutos.add(auto1);algunosAutos.add(auto2);algunosAutos.add(auto3)
		auto4 = new CachedCar => [patente = "sdasdsde"]
		auto5 = new CachedCar => [patente = "dsddsdass"]
		auto6 = new CachedCar => [patente = "NLJWINS"]
		otroListado = newArrayList
		otroListado.add(auto4);algunosAutos.add(auto5);algunosAutos.add(auto6)
	}
	
	@Test
	def void test_cacheo_de_datos_funciona_correctamente() {
		
		SUT.cachear(unaFecha,unaUbicacion,algunosAutos)
		
		
		var BusquedaPorDiaReserva resultado =  SUT.getCached(unaFecha,unaUbicacion)
		
		Assert.assertEquals(resultado.autos , algunosAutos)
	}
	
	@Test
	def void test_cacheo_de_datos_nuevos_reemplaza_correctamente() {
		
		SUT.cachear(unaFecha,unaUbicacion,algunosAutos)
		SUT.cachear(unaFecha,unaUbicacion,otroListado)
		algunosAutos.addAll(otroListado)
		
		var BusquedaPorDiaReserva resultado =  SUT.getCached(unaFecha,unaUbicacion)
		
		Assert.assertEquals(resultado.autos , algunosAutos)
	}
	
	@Test
	def void test_autos_cacheados_en_cierta_fecha_son_eliminados_correctamente() {
		
		SUT.cachear(unaFecha,unaUbicacion,algunosAutos)
		var fechaAnterior = nuevaFecha(1993,1,1)
		var fechaPosterior = nuevaFecha(2000,12,12)
		
		SUT.deleteCachedCarBetween(fechaAnterior,fechaPosterior,auto3)
		var resultado = SUT.getCachedCarsBetween(fechaAnterior,fechaPosterior)
		
		Assert.assertTrue(contains(resultado,auto3))
	}
	
	def private contains(List<BusquedaPorDiaReserva> resultado,CachedCar autoQueDebeContener) {
		return resultado.findFirst[each | each.autos.contains(autoQueDebeContener)] == null
	}
	
	@After
	def void limpiar_base_de_datos() {
		SUT.cleanCache
	}
	
}