"Thrown whenever validation has invalidated"
shared class ValidationError(
	shared Throwable[] errors
) extends Exception("Validation failed, with errors:\n ``createMessage(errors)``") {}

String createMessage(Throwable[] errors){
	return errors.map((Throwable element) => element.message).reduce((String partial, String element) => "``partial``,\n\r`` element ``") else "";
}