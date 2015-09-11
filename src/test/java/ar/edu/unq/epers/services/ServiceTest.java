/**
 * 
 */
package ar.edu.unq.epers.services;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;

import ar.edu.unq.epers.excepciones.IngresoNoValidoException;
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException;
import ar.edu.unq.epers.excepciones.UsuarioYaExisteException;
import ar.edu.unq.epers.excepciones.ValidacionException;
import ar.edu.unq.epers.extensions.MailService;
import ar.edu.unq.epers.homes.UserDao;
import ar.edu.unq.epers.model.Usuario;


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
		when(unUserDao.getUsuarioPorUsername(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		when(otroUser.getValidez()).thenReturn(false);
		
		sut.registrarUsuario(unUsuario);

		verify(unUsuario).setValidez(false);
		verify(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		verify(unUserDao).update(unUsuario);
		
	}
	
	@Test
	public void testRegistrarUnUsuarioSinReemplazo() throws UsuarioYaExisteException{
		
		when(unUserDao.getUsuarioPorUsername(username)).thenReturn(null);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());

		sut.registrarUsuario(unUsuario);
			
		verify(unUserDao).save(unUsuario);
	}
	
	@Test (expected = UsuarioYaExisteException.class)
	public void testRegistrarUnUsuarioException() throws UsuarioYaExisteException{
		
		Usuario otroUser = mock(Usuario.class);
		when(unUserDao.getUsuarioPorUsername(username)).thenReturn(otroUser);
		when(unUsuario.getNombreDeUsuario()).thenReturn(username);
		doNothing().when(unUsuario).setValidez(false);
		doNothing().when(unUsuario).setCodigo(new Integer (unUsuario.hashCode()).toString());
		when(otroUser.getValidez()).thenReturn(true);
		
		sut.registrarUsuario(unUsuario);
	}

	
	
	@Test
     public void ingresoUsuarioValido() throws UsuarioNoExisteException,IngresoNoValidoException
	{
         when(unUserDao.getUsuarioPorUsername("pepita")).thenReturn(unUsuario)	;
         when(unUsuario.ingresoValido("1234")).thenReturn(true);
     	
         assertEquals(unUsuario, sut.ingresarUsuario("pepita", "1234"));    
	}
       
	@Test  (expected = UsuarioNoExisteException.class)
	public void ingresoUsuarioInvalido()throws UsuarioNoExisteException
	{
		when(unUserDao.getUsuarioPorUsername("jose")).thenReturn(null);
		sut.ingresarUsuario("jose","1234");

		
	}
	
}