import ceylon.language.meta.model {

	Function
}
shared class Multi<Parameters> satisfies Verification given Parameters satisfies Anything[] {
	
	shared Function<Anything,Parameters> reference;
	{Parameters*}() extractor;
	
	shared new (Function<Anything,Parameters> reference, {Parameters*} iterable) {
	
		this.reference = reference;
		this.extractor = () => iterable;
	}
	shared new extracted(Function<Anything,Parameters>  reference, {Parameters*}() extractor) {
		this.reference = reference;
		this.extractor = extractor;
	}
	
	
	shared actual {Exception*} verify {
		value parameters = extractor();
		return  parameters.map((Parameters element) {
				try {
					if (is Throwable result = reference(*element)) {
						return Exception("Constrain not fullfilled for ``reference`` with parameters ``element``", result);
					}
				} catch (Throwable error) {
					return Exception("Constrain not fullfilled for ``reference`` with parameters ``element``", error);
				}
				return null;
			}).narrow<Throwable>();
		
	}
	string => "``reference``: ``extractor()```";
}