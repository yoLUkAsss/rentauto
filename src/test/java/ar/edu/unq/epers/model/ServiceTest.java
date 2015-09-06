/**
 * 
 */
package ar.edu.unq.epers.model;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import ar.edu.unq.epers.extensions.MailService;
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
	String username;
	MailService unMs;
	

	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		
		sut = new Service();
		unUsuario = mock(Usuario.class);
		unUserDao = mock(UserDao.class);
		unMs = mock(MailService.class);
		sut.setUdao(unUserDao);
		sut.setMS(unMs);
		username = "pepita";
	}

	@Test
	public void testDeValidarCuentaInvalida() {
		
		String codigo = "g43u8s";

		when(unUserDao.getUsuarioPorCodigoDeValidacion(codigo)).thenReturn(null);
		
		try {
			sut.validarCuenta(codigo);
			fail();
		} catch (ValidacionException e) {
			//Deberia entrar por aca
		}		
	}
	
	@Test
	public void testDeValidarCuenta() {
		
		String codigo = "g43u8s";

		when(unUserDao.getUsuarioPorCodigoDeValidacion(codigo)).thenReturn(unUsuario);
		
		try {
			sut.validarCuenta(codigo);
		} catch (ValidacionException e) {
			//No entra por aca
		}
		
		verify(unUsuario).validar();
		
	}
	
	@Test
	public void testRegistrarUnUsuarioConReemplazo() {
		
		Usuario otroUser = mock(Usuario.class);
		when(unUserDao.getUsuario(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		when(otroUser.getValidez()).thenReturn(false);
		
		try {
			sut.registrarUsuario(unUsuario);
		} catch (UsuarioYaExisteException e) {
			//Este no falla
			fail();
		}
		
		verify(unUserDao).update(unUsuario);
		
	}
	
	@Test
	public void testRegistrarUnUsuarioSinReemplazo() {
		
		when(unUserDao.getUsuario(username)).thenReturn(null);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		
		try {
			sut.registrarUsuario(unUsuario);
		} catch (UsuarioYaExisteException e) {
			//Este no falla
			fail();
		}
		
		verify(unUserDao).save(unUsuario);
	}
	
	@Test
	public void testRegistrarUnUsuarioException() {
		
		Usuario otroUser = mock(Usuario.class);
		when(unUserDao.getUsuario(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		when(otroUser.getValidez()).thenReturn(true);
		
		try {
			sut.registrarUsuario(unUsuario);
			fail();
		} catch (UsuarioYaExisteException e) {
			//Deberia entrar por aca
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
			fail();
		}catch (UsuarioNoExisteException e){
			
		}

		
	}
	
}