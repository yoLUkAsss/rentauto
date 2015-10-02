package ar.edu.unq.epers.services

import ar.edu.unq.epers.homes.AutoHome
import ar.edu.unq.epers.homes.CategoriaHome
import ar.edu.unq.epers.homes.SessionManager
import ar.edu.unq.epers.homes.UbicacionHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion

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
	
	def guardarReserva(Integer id,Reserva reserva) {
		SessionManager.runInSession([
			var auto = new AutoHome().get(id)
			auto.agregarReserva(reserva)
			new AutoHome().save(auto)
			auto
		]);
		
	}
	
}