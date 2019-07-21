shared class Validx(
	shared {Verification*} verifications) {
	
	shared ValidationError? validate {
		value sequence = verifications.flatMap((Verification element)  { 
			switch(verified = element.verify)
			case (is Exception) { return {verified}; }
			else case (is {Exception*}) { return verified; }
			else { return empty;}
		}).sequence();
		if (!sequence.empty) {
			return ValidationError(sequence);
		}
		return null;
	}
}
