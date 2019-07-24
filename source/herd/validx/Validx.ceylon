void execute({Validation+} validations){
	value sequence = validations.flatMap((Validation element)  { 
		switch(verified = element.verify)
		case (is Exception) { return {verified}; }
		else case (is {Exception*}) { return verified; }
		else { return empty;}
	}).sequence();
	if (!sequence.empty) {
		throw ValidationError(sequence);
	}
}


"Entry point, executes validation process. If [[ValidationError]]  is thrown has failed one or more verifications has been invalidated."	
see(`class Single`,`class Multi`)
throws(`class ValidationError`)
shared void validate(
	"Validations to be executed"
	{Validation+} validations
) {
	execute(validations);
}



"Creatates validator for further use."
shared class Validx{

	{Validation+} validations;
	shared new(
		"Validations to be executed further"
		{Validation+} validations
	){
		this.validations = validations;
	}

	"Entry point, executes validation process. If [[ValidationError]]  is thrown has failed one or more verifications has been invalidated."	
	see(`class Single`,`class Multi`)
	throws(`class ValidationError`)
	shared void validate(){
		execute(validations);
	}
	
}