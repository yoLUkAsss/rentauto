package ar.edu.unq.epers.homes

import ar.edu.unq.epers.model.Empresa

class EmpresaHome {
	
	def get(Integer id){
		return SessionManager.getSession().get(typeof(Empresa) ,id) as Empresa
	}

	def save(Empresa a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
}