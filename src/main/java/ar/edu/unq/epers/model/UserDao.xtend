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
	def Usuario getUsuario(String s){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("Select * from usuario  where username=?");
			
		try{
			ps.setString(1, s);
			var ResultSet rs = ps.executeQuery();
			if(rs.next()){
				return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
					rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getBoolean("validez"),rs.getString("codigo"),rs.getString("password"))
			}else{
				return null; //throw new UsuarioNoExisteExceotion
			}
		}catch(Exception e){
			throw new UsuarioYaExisteException; //throw e
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}	
	}
	
	def save(Usuario u){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("insert into usuario(?,?,?,?,?,?,?,?)");
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
		ps.setString(1,u.nombreDeUsuario);
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
		
		try{
			ps.setString(1, codigo);
			var ResultSet rs = ps.executeQuery();
			if(rs.next()){
				return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
					rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getBoolean("validez"),rs.getString("codigo"),rs.getString("password"))
			}else{
				return null;
			}
			
		}catch(Exception e){
			throw new UsuarioNoExisteException; //preguntar
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
	}
	
	def Usuario ingresarUsuario(String userName, String password1)
	{
		
		   var conn = this.getConnection();
		   var ps = conn.prepareStatement("Select username from usuario  where username = ? and password = ?");
	    
	    	try {
           val ResultSet rs = ps.executeQuery();
			   if(rs.next()){ 
			 	
			 	      return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
			 		  rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getBoolean("validez"),rs.getString("codigo"),rs.getString("password"))
			 		   
			                            
		       }
		     else
		        { return null;}
			} catch (Exception e) {
				throw e;
			} finally {
				if(ps != null)
					ps.close();
				if(conn != null)
					conn.close();
			}
		
		}
	
}