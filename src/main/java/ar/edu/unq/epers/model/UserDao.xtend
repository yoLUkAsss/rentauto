package ar.edu.unq.epers.model

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


class UserDao {
	
	Connection conn;
	PreparedStatement ps;
	
	def Usuario getUsuario(Usuario u){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("Select * from usuario  where username=? and validez");
		
			ps.setString(1, u.nombreDeUsuario);
			var ResultSet rs = ps.executeQuery();
			if(rs.next()){
				return new Usuario(rs.getString("nombre"),rs.getString("apellido"),
					rs.getString("username"),rs.getString("email"),rs.getString("fechaNacimiento"),rs.getString("password"))
			}else{
				return null;
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
		
	}
	
	
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/rentautoUsuario?user=root&password=root");
	}
	
	
	def public cambiarPassword(String userName,String password, String nuevaPassword,
	Service s){
		var conn = this.getConnection();
		var ps = conn.prepareStatement("Select username from usuario  where username=? and password=?");
		
		try{
			ps.setString(1, userName);
			ps.setString(2, password);
			var ResultSet rs = ps.executeQuery();
			if(rs.next()){
				throw new NuevaPasswordInvalida;
			}
			var ps2 =conn.prepareStatement("update usuario set password="+nuevaPassword+ " where usuario=? 
			and password=?");
			ps2.setString(1,userName);
			ps2.setString(2,password);
			ps2.execute();
			ps2.close();
			
		}catch(Exception e){
			throw new NuevaPasswordInvalida;
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
									
	
	
	}
	
}