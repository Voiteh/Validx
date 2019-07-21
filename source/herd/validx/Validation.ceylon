"Defines a way to execute verification for validation. "
shared interface  Validation
{
	"Verifes wheter provided data is valid"
	shared formal Exception?|{Exception*} verify;

}