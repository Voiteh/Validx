import ceylon.language.meta.model {

	Function
}
"
 Multi verification, provides ability to execute verification over iterable parameters . 
 Use default constructor if  [[Parameters]] are provided eagerly, else [[extracted]] to extract them lazily,
  when [[verify]] is called rather than durring [[Multi]] creation. 
 "
shared class Multi<Parameters> satisfies Validation given Parameters satisfies Anything[] {
	
	"Reference to valdiation function"
	shared Function<Anything,Parameters> reference;
	"Parameters provided through extrator"
	{Parameters*}() extractor;
	
	
	shared new (
		"Reference to valdiation function"
		Function<Anything,Parameters> reference, 
		"Eagerly provided parameters"
		{Parameters*} iterable
	) {
		this.reference = reference;
		this.extractor = () => iterable;
	}
	shared new extracted(
		"Reference to valdiation function"
		Function<Anything,Parameters>  reference,
		"Lazyly provided parameters through extractor" 
		{Parameters*}() extractor
	) {
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