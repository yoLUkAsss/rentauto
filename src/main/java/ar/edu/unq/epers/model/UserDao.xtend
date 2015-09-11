package ar.edu.unq.epers.model

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


class UserDao {
	
	Connection conn;
	PreparedStatement ps;
	
	
	 
	/*
	 * Retorna un usuario de acuerdo al nombre de usuario.
	 */
	def Usuario getUsuario(String username){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("Select * from usuario  where username=?");
			
		ps.setString(1, username);
		var ResultSet rs = ps.executeQuery();
		if(rs.next()){
			return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
				rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getBoolean("validez"),rs.getString("codigo"),rs.getString("password"))
		}
			
		

		if(ps != null)
			ps.close();
		if(conn != null)
			conn.close();
		return null; 

	}
	
	def save(Usuario u){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("insert into usuario (nombre,apellido,username,email,fechaNacimiento,validez,codigo,password) values (?,?,?,?,?,?,?,?)");
		ps.setString(1, u.nombreDeUsuario);
		ps.setString(2, u.apellido);
		ps.setString(3, u.nombreDeUsuario);
		ps.setString(4, u.email);
		ps.setString(5, u.fechaDeNacimiento);
		ps.setBoolean(6,u.validez);
		ps.setString(7,u.codigo);
		ps.setString(8,u.password);
		ps.execute();
		ps.close()
		conn.close()
	}
	
	def update(Usuario u){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("update usuario set nombre=?, apellido=?, username=?, email=?, fechaNacimiento=?, validez=?, codigo=?, password=? where username=?");
		ps.setString(1,u.nombre);
		ps.setString(2, u.apellido);
		ps.setString(3, u.nombreDeUsuario);
		ps.setString(4, u.email);
		ps.setString(5, u.fechaDeNacimiento);
		ps.setBoolean(6,u.validez);
		ps.setString(7,u.codigo);
		ps.setString(8,u.password);
		ps.setString(9,u.nombreDeUsuario);
		ps.execute();
		ps.close()
		conn.close()
	}
	
	
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/rentautoUsuario?user=root&password=root");
	}
	
	
	
	
	//El siguiente metodo obtiene a un Usuario de acuerdo a su codigo de validacion,
	//este es unico en la base de datos...
	//Null en caso contrario
	
	def getUsuarioPorCodigoDeValidacion(String codigo) {
		var conn = this.getConnection();
		var ps = conn.prepareStatement("select * from usuario where codigoValidacion = ?");
		
		
		ps.setString(1, codigo);
		var ResultSet rs = ps.executeQuery();
		if(rs.next()){
			return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
				rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getBoolean("validez"),rs.getString("codigo"),rs.getString("password"))
		}
		
		if(ps != null)
			ps.close();
		if(conn != null)
			conn.close();
		return null;
		
	}
	
	
	
}
