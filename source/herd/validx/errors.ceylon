"Thrown whenever validation has invalidated"
shared class ValidationError(
	shared Throwable[] errors
) extends Exception("Validation failed error: ``errors```") {}

