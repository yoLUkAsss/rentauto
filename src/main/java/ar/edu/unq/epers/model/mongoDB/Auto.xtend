package ar.edu.unq.epers.model.mongoDB

import ar.edu.unq.epers.model.Categoria
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class AutoCalificado {
	String username;
	String patente;
	Categoria categoria;
	Calificacion calificacion;
	String comentario;
	Visibilidad visibilidad;
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new(){
		
	}
	
	new(String username, String patente, Categoria categoria,Calificacion calificacion,String comentario,Visibilidad visibilidad) {
		this.username = username
		this.patente = patente
		this.categoria = categoria
		this.calificacion = calificacion
		this. comentario = comentario
		this.visibilidad = visibilidad
	}
	
}

enum Calificacion{
	
	EXCELENTE,BUENO,REGULAR, MALO
}

enum Visibilidad{
	PUBLICO,PRIVADO,SOLOAMIGOS,AMIGOSDEAMIGOS
}