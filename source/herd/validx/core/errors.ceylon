shared class ValidationError(
	shared Throwable[] errors
) extends Exception("Validation failed error: ``errors```") {}

