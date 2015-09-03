/**
 * 
 */
package ar.edu.unq.epers.model;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import junit.framework.Assert;

import static org.mockito.Mockito.*;


/**
 * @author alumno
 *
 */
public class ServiceTest {
	
	Service sut;
	Usuario unUsuario;
	UserDao unUserDao;
	

	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		
		sut = new Service();
		unUsuario = mock(Usuario.class);
		unUserDao = mock(UserDao.class);
		sut.setUdao(unUserDao);
	}

	@Test
	public void testDeValidarCuenta() {
		
		String codigo = "g43u8s";

		when(unUserDao.getUsuarioPorCodigoDeValidacion(codigo)).thenReturn(unUsuario);
		
		try {
			sut.validarCuenta(codigo);
		} catch (ValidacionException e) {
			e.printStackTrace();
		}
		
		verify(unUsuario).validar();
		
	}
	
	@Test
	public void testRegistrarUnUsuario() {
		
		when(unUserDao.getUsuario(unUsuario)).thenReturn(unUsuario);
		
		try {
			sut.registrarUsuario(unUsuario);
		} catch (UsuarioYaExisteException e) {
			//En este caso, no falla
		}
		
		verify(unUserDao).save(unUsuario);
	}
	
	@Test
	public void testRegistrarUnUsuarioInvalido() {
		
		when(unUserDao.getUsuario(unUsuario)).thenReturn(unUsuario);
		
		try {
			sut.registrarUsuario(unUsuario);
		} catch (UsuarioYaExisteException e) {
			//En este caso, no falla
		}
		
	}
	
	@Test
     public void ingresoUsuarioValido() throws UsuarioNoExisteException
	{
         when(unUserDao.ingresarUsuario("pepe","1234")).thenReturn(unUsuario)	;     
     	
         try{
        	 sut.ingresarUsuario("pepe", "1234");
         }catch (UsuarioNoExisteException e){
        	 
         }
         assertEquals(unUsuario, sut.ingresarUsuario("pepe", "1234"));    
	}
       
	@Test 
	public void ingresoUsuarioInvalido()throws UsuarioNoExisteException
	{
		when(unUserDao.ingresarUsuario("jose", "1234")).thenReturn(null);
		try{
			sut.ingresarUsuario("jose","1234");
		}catch (UsuarioNoExisteException e){
			
		}

		
	}
	
}