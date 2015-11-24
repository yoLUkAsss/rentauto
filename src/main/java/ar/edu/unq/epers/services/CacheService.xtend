package ar.edu.unq.epers.services

import java.util.Date
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.homes.AdminHome
import com.datastax.driver.mapping.MappingManager
import ar.edu.unq.epers.model.BusquedaPorDiaReserva
import java.util.List

class CacheService {
	
	new () {}
	
	
	def cachear (Date dia , Ubicacion ubicacion , List <Auto> autos) {
		AdminHome.getInstance.runInSession([|
			
			var miMapping = new MappingManager(AdminHome.getInstance.session)
			var res = miMapping.mapper(BusquedaPorDiaReserva).get(dia,ubicacion)
			if (res == null) {
				res = new BusquedaPorDiaReserva(dia,ubicacion,autos)
			} else {
				for (Auto auto : autos) {
					res.agregarAuto(auto)
				}
			} 
			miMapping.mapper(BusquedaPorDiaReserva).save(res)
			null
		])
	}
	
	def getCached (Date dia , Ubicacion ubicacion) {
		AdminHome.getInstance.runInSession([|
			
			var miMapping = new MappingManager(AdminHome.getInstance.session)
			return miMapping.mapper(BusquedaPorDiaReserva).get(dia,ubicacion)
			
		])
	}
	
	def deleteCachedCarBetween(Date inicio , Date fin , Auto auto) {
		var res = AdminHome.getInstance.allDataBetweenDates(inicio,fin)
		for (BusquedaPorDiaReserva elem : res) {
			if (elem.autos.contains(auto)) {
				elem.borrarAuto(auto)
			}
			this.cachear(inicio,elem.ubicacion,elem.autos)
		}			
	}
}