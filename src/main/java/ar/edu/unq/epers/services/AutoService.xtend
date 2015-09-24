package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.homes.AutoHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.homes.CategoriaHome
import ar.edu.unq.epers.homes.UbicacionHome

class AutoService {
	
	
	def consultarAuto(Integer id) {
		SessionManager.runInSession([
			new AutoHome().get(id)
		])
	}

	def crearAuto(String marca, String modelo, Integer anio, String patente, Categoria categoria, Double costoBase, Ubicacion ubicacionInicial) {
		SessionManager.runInSession([
			var auto = new Auto(marca, modelo, anio,patente,categoria,costoBase,ubicacionInicial);
			new CategoriaHome().save(categoria)
			new UbicacionHome().save(ubicacionInicial)
			new AutoHome().save(auto)
			auto
		]);
	}

	def modificarUbicacion(Integer id, Ubicacion ub) {
		SessionManager.runInSession([
			var home = new AutoHome()
			var auto = home.get(id)
			auto.ubicacionInicial = ub
			home.save(auto)
			auto
		]);
	}
}