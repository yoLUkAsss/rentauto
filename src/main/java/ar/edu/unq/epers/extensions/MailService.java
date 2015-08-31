package ar.edu.unq.epers.extensions;

import ar.edu.unq.epers.model.Mail;

public interface MailService {

	void enviarMail(Mail m) throws EnviarMailException;
}
