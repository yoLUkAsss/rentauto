package ar.edu.unq.epers.model

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import ar.edu.unq.epers.extensions.MailService

class UserDao {
	
	Connection conn;
	PreparedStatement ps;
	
	def registrarUsuario(Usuario u,Service s){		

		var conn = this.getConnection();
		var ps = conn.prepareStatement("Select username from usuario  where " + 
															"(?)" + "=username and validez");	

		try{
			ps.setString(1, u.nombreDeUsuario);
			var ResultSet rs = ps.executeQuery();
			if(rs.next()){
				throw new UsuarioYaExisteException;
			}
			var ps2 = conn.prepareStatement("insert into usuario(?,?,?,?,?,?,?)");
			ps.setString(1, u.nombreDeUsuario);
			ps.setString(2, u.apellido);
			ps.setString(3, u.nombreDeUsuario);
			ps.setString(4, u.email);
			ps.setString(5, u.fechaDeNacimiento);
			ps.setBoolean(6,false);
			ps.setInt(7,u.hashCode());
			
			s.MS.enviarMail(new Mail(s.email,u.email,"Verificacion de autenticacion",
				"autetificate con el codigo: " + new Integer(u.hashCode()).toString()
			));
		}catch(Exception e){
			throw new UsuarioYaExisteException;
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
		
		
		
		
	}
	
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/rentautoUsuario?user=root&password=root");
	}
	
	def private setNull(){
		conn=null;
		ps=null;
	}
	
}