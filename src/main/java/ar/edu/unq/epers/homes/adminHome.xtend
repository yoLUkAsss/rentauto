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

@Accessors
class AdminHome {
	
	
	public static AdminHome instance = new AdminHome("autosPorDia")
	private Cluster cluster;
	private Session session;
	private final String serverIP = "127.0.0.1";
	private String keyspace;
	private String schema = "autosPorDia"
	
	
	new(String schema){
		this.createSchema(schema)
	}
	
	def static getInstance(){
		return instance
	}
	
	def createSchema(String schema){
		runInSession([
			session.execute("CREATE KEYSPAcE IF NOT EXISTS " + schema + " WITH replication = {'class':'SimpleStrategy','replication_factor':1}")
		])
		keyspace = schema;
	}
	
	def allDataBetweenDates(Date inicio , Date end) {
		var values = getInstance.runInSession[|
			session.execute("SELECT * FROM " + this.schema + " WHERE dia >= " + inicio.toString + "AND dia " +  "<= '2013-08-13 23:59:00+0200'")
		]
		var mimap = new MappingManager(session).mapper(BusquedaPorDiaReserva)
		return mimap.map(values).toList
	} 
	
	
	
	def <T> runInSession(Function0<T> cmd){
		
		try {
			cluster = Cluster.builder()
		  		.addContactPoints(serverIP)
		  		.build();
		
			session = cluster.connect(keyspace);
			var MappingManager mappingManager = new MappingManager(session);
			cmd.apply()
			
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (session != null)
				session.close();
			if(cluster != null)
				cluster.close();
		}

	}
	
	
		
		
	
}