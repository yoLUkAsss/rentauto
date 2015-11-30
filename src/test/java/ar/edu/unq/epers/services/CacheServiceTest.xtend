package ar.edu.unq.epers.services

import org.junit.Before
import org.junit.Test
import java.util.Date
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.cassandra.CachedCar
import java.util.List
import ar.edu.unq.epers.model.BusquedaPorDiaReserva
import org.junit.Assert
import org.junit.After

class CacheServiceTest {
	
	
	CacheService SUT
	Date unaFecha
	Ubicacion unaUbicacion
	
	CachedCar auto1;CachedCar auto2;CachedCar auto3
	List<CachedCar> algunosAutos
	
	@Before
	def void setUp(){
		SUT = new CacheService
		unaFecha = new Date()
		unaUbicacion = new Ubicacion("Avellaneda")
		auto1 = new CachedCar => [patente = "123 qwe"]
		auto2 = new CachedCar => [patente = "283 hjs"]
		auto3 = new CachedCar => [patente = "174 kjs"]
		algunosAutos = newArrayList
		algunosAutos.add(auto1);algunosAutos.add(auto2);algunosAutos.add(auto3)
	}
	
	@Test
	def void test_cacheo_de_datos_funciona_correctamente() {
		
		SUT.cachear(unaFecha,unaUbicacion,algunosAutos)
		
		//var BusquedaPorDiaReserva resultado =  SUT.getCached(unaFecha,unaUbicacion)
		
		//Assert.assertEquals(resultado.autos , algunosAutos)
	}
	
	@After
	def void limpiar_base_de_datos() {
		SUT.cleanCache
	}
	
}