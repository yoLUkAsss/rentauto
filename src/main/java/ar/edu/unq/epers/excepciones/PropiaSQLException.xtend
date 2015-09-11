package ar.edu.unq.epers.excepciones

import java.sql.SQLException

class PropiaSQLException extends SQLException {
	
	new (String descripcion , SQLException ex) {
		super(descripcion,ex)
	}
	
	
}