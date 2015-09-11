package ar.edu.unq.epers.model

import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*
import static org.mockito.Mockito.*

class UserDaoTest {
	
	UserDao sut;
	Usuario u;
	Usuario u2;
	
	@Before
	def void setUp() {
		sut = new UserDao()
		u = new Usuario("traspie","hidalgo","thidalgo","thidalgoArrobamailUnq.com","2001-11-11",false,"pass123","0");
		u2 =new Usuario("traspie2","hidalgo","thidalgo","thidalgoArrobamailUnq.com","2001-11-11",false,"pass123","0");
	}
	
	@Test
	def void testSaveyGetUsuario(){
			sut.save(u);
			assertEquals(u,sut.getUsuarioPorUsername("thidalgo"))
			sut.delete(u.nombreDeUsuario);
		
	}
	
	@Test
	def void testUpdate(){
			sut.save(u);
			sut.update(u2);
			assertEquals(u2.nombre,sut.getUsuarioPorUsername("thidalgo").nombre)
			sut.delete(u.nombreDeUsuario)

	}
	 
}