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

	@Test(expected = ValidacionException.class)
	public void testDeValidarCuentaInvalida() throws ValidacionException {
		String codigo = "g43u8s";

		when(unUserDao.getUsuarioPorCodigoDeValidacion(codigo)).thenReturn(null);
		sut.validarCuenta(codigo);
	}
	
	@Test
	public void testDeValidarCuenta() throws ValidacionException {
		
		String codigo = "g43u8s";
		when(unUserDao.getUsuarioPorCodigoDeValidacion(codigo)).thenReturn(unUsuario);
		
		sut.validarCuenta(codigo);

		verify(unUsuario).validar();
		
	}
	
	@Test
	public void testRegistrarUnUsuarioConReemplazo() throws UsuarioYaExisteException{
		
		Usuario otroUser = mock(Usuario.class);
		when(unUserDao.getUsuario(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		when(otroUser.getValidez()).thenReturn(false);
		
		sut.registrarUsuario(unUsuario);

		verify(unUsuario).setValidez(false);
		verify(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		verify(unUserDao).update(unUsuario);
		
	}
	
	@Test
	public void testRegistrarUnUsuarioSinReemplazo() throws UsuarioYaExisteException{
		
		when(unUserDao.getUsuario(username)).thenReturn(null);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());

		sut.registrarUsuario(unUsuario);
			
		verify(unUserDao).save(unUsuario);
	}
	
	@Test (expected = UsuarioYaExisteException.class)
	public void testRegistrarUnUsuarioException() throws UsuarioYaExisteException{
		
		Usuario otroUser = mock(Usuario.class);
		when(unUserDao.getUsuario(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		when(otroUser.getValidez()).thenReturn(true);
		
		sut.registrarUsuario(unUsuario);
	}

	
	
	@Test
     public void ingresoUsuarioValido() throws UsuarioNoExisteException,IngresoNoValidoException
	{
         when(unUserDao.getUsuario("pepita")).thenReturn(unUsuario)	;
         when(unUsuario.getPassword()).thenReturn("1234");
         when(unUsuario.getValidez()).thenReturn(true);
     	
         assertEquals(unUsuario, sut.ingresarUsuario("pepita", "1234"));    
	}
       
	@Test  (expected = UsuarioNoExisteException.class)
	public void ingresoUsuarioInvalido()throws UsuarioNoExisteException
	{
		when(unUserDao.getUsuario("jose")).thenReturn(null);
		sut.ingresarUsuario("jose","1234");

		
	}
	
}