package ar.edu.unq.epers.homes

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import org.eclipse.xtext.xbase.lib.Functions.Function0
import com.datastax.driver.mapping.MappingManager
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import ar.edu.unq.epers.model.BusquedaPorDiaReserva
import java.util.List
import com.datastax.driver.core.Row

/**
 * Objeto con el cual nos comunicamos con Cassandra para manejar la base de datos NoSQL (Key-Value Oriented)
 */
@Accessors
class AdminHome {
	
	//Nombre de la tabla
	public static AdminHome instance = new AdminHome("autospordia")
	private Cluster cluster
	private Session session
	private final String serverIP = "127.0.0.1"
	private String schema = "autospordia"
	private Boolean hayInstance = false
	
	
	new(String schema){
		startClusterConnection
		this.createSchema(schema)
		hayInstance = true
	}
	
	def static getInstance(){
		return instance
	}
	
	def createSchema(String schema){
		
		runInSession([
			
			System.out.println("Creating KeySpace")
			
			session.execute("CREATE KEYSPACE IF NOT EXISTS " + schema + 
			" WITH replication = {'class':'SimpleStrategy','replication_factor':3}")
			
			session.execute("CREATE TYPE IF NOT EXISTS "+schema+".cachedcar (" +
			"patente text," +
			"categoria text," +
			"marca text," +
			"modelo text," +
			");")
			
			System.out.println("Creating Table")
			
			session.execute("CREATE TABLE IF NOT EXISTS "+schema+".autosCacheados (" +
			"dia timestamp," +
			"ubicacion text," +
			"autos list<frozen <cachedcar>>," +
			"PRIMARY KEY (dia,ubicacion)" +
			");")
			
			System.out.println("All Created")
			
			schema
			
		])
	}
	
	def allDataBetweenDates(Date inicio , Date fin) {
		var values = getInstance.runInSession[|
			session.execute("SELECT * FROM " + this.schema + " WHERE dia >= " + inicio.toString + "AND dia <= " + fin.toString)
		]
		var mimap = new MappingManager(session).mapper(BusquedaPorDiaReserva)
		return mimap.map(values).toList
	} 
	
	
	
	def <T> runInSession(Function0<T> cmd){
		
		try {
			
		
			System.out.println("Iniciating Session... Wait")
			if (hayInstance) { session = cluster.connect(schema) }
			else session = cluster.connect();
			System.out.println("Session iniciated... OK")
			//var MappingManager mappingManager = new MappingManager(session);
			cmd.apply()
			
			
		} catch (Exception e) {
			e.printStackTrace
			throw new RuntimeException(e);
		} finally {
			if (session != null)
				session.close();
//			if(cluster != null)
//				closeClusterConnection();
		}

	}
	
	
		
	def startClusterConnection() {
		System.out.println("Establishing connection with cluster...")
		cluster = Cluster.builder()
		  		.addContactPoints(serverIP)
		  		.build();
		System.out.println("Connection with Cluster... Completed")
	}	
	
	def closeClusterConnection() {
		System.out.println("Closing connection with Cluster... ")
		cluster.close
		System.out.println("Connection with Cluster... Close... Bye")
	}
	
	def cleanDatabase() {
		runInSession[|
			session.execute("DROP TABLE "+schema+".autosCacheados")
			session.execute("DROP KEYSPACE "+schema)
		]
	}
	
	
	
	
	
	
	
	
	
	
}