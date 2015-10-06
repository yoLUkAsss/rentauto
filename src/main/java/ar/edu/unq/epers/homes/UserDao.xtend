package ar.edu.unq.epers.homes

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.eclipse.xtext.xbase.lib.Functions.Function1
import ar.edu.unq.epers.model.Usuario

class UserDao {
	
	Connection conn;
	PreparedStatement ps;
	
	def setAtributosPrincipales(PreparedStatement ps,Usuario u ) {
		ps.setString(1, u.nombre);
		ps.setString(2, u.apellido);
		ps.setString(3, u.nombreDeUsuario);
		ps.setString(4, u.email);
		ps.setString(5, u.fechaDeNacimiento);
		ps.setBoolean(6,u.validez);
		ps.setString(7,u.codigo);
		ps.setString(8,u.password);
	}
	
	def ejecutame(Function1<Connection, Usuario> bloque) {
		try{
			this.conn = this.getConnection()
		    val usuario = bloque.apply(conn)
		    return usuario
	    }catch(Exception e){
	    	throw e
	    }finally{
	    	if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
	    }
	}

	def void delete(String username){
		this.ejecutame([connection | 
			this.ps =connection.prepareStatement("delete from usuario where username=?");
			ps.setString(1,username);
			ps.execute();
			return null;							
		])
	}
	
	def save(Usuario u){
		this.ejecutame([connection |
		this.ps = connection.prepareStatement("insert into usuario (nombre,apellido,username,email,fechaNacimiento,validez,codigo,password) values (?,?,?,?,?,?,?,?)");
		setAtributosPrincipales(ps,u)
		ps.execute();
		null
		])
	}
	
	def update(Usuario u){
		this.ejecutame([connection |
		this.ps = connection.prepareStatement("update usuario set nombre=?, apellido=?, username=?, email=?, fechaNacimiento=?, validez=?, codigo=?, password=? where username=?");
		setAtributosPrincipales(ps,u)
		ps.setString(9,u.nombreDeUsuario);
		ps.execute();
		return null;
		])
	}
	
	def getUsuarioPorCodigoDeValidacion(String codigo) {
		return this.getUsuario("codigo",codigo)
		
	}
	
	def getUsuarioPorUsername(String username) {
		return (this.getUsuario("username",username))
	}
	
	
//=========================
//Metodos privados
//==========================		
		
	
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/rentautoUsuario?user=root&password=root");
	}
	
	//El siguiente metodo obtiene a un Usuario de acuerdo a su codigo de validacion,
	//este es unico en la base de datos...
	//Null en caso contrario
	
	def private Usuario getUsuario(String atributo , String valorBuscado){
		this.ejecutame([connection | 
						this.ps = connection.prepareStatement("Select * from usuario  where ?=?");	
						ps.setString(1,atributo)
						ps.setString(2,valorBuscado)
						var ResultSet rs = ps.executeQuery();
						if(rs.next()){
							return new Usuario(
								rs.getString("nombre"),
								rs.getString("apellido"),
								rs.getString("username"),
								rs.getString("email"),
								rs.getString("fechaNacimiento"),
								rs.getBoolean("validez"),
								rs.getString("codigo"),
								rs.getString("password"))
						}
						return null
						])
	}
	
}
