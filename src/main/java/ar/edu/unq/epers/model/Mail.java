package ar.edu.unq.epers.model;

import org.eclipse.xtend.lib.annotations.Accessors;

@Accessors
public class Mail {
	
	private String from;
	private String to;
	private String subject;
	private String body;
	private Integer codigo;
	
	private static Integer codigoSiguiente=0;
	
	
	public Mail(){}
	
	public Mail(String from,String to,String subject, String body){
		this.setFrom(from);
		this.setTo(to);
		this.setSubject(subject);
		this.setBody(body);
		this.setCodigo(codigoSiguiente);
		codigoSiguiente++;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}
	
}
