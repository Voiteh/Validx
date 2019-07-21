import ceylon.language.meta.model {

	Function
}

"
 Single verification, provides ability to execute once over all provided parameters. 
 Use default constructor if  [[Parameters]] are provided eagerly, else [[extracted]] to extract them lazily,
  when [[verify]] is called rather than durring [[Single]] creation. 
 "
shared class  Single<Parameters> satisfies Validation given Parameters satisfies Anything[] {

	"Reference to valdiation function"
	shared Function<Anything,Parameters>reference;
	"Parameters provided through extrator" 
	Parameters() extractor;
	
	shared new (
		"Reference to valdiation function"
		Function<Anything,Parameters> reference,
		"Eagerly provided parameters" 
		Parameters parameters
	){
		this.reference=reference;
		this.extractor=() => parameters;
	}
	
	shared new extracted(
		"Reference to valdiation function"
		Function<Anything,Parameters>  reference,
		"Eagerly provided parameters"
		Parameters() extractor
	 ){
		this.reference=reference;
		this.extractor=extractor; 
	}

	shared actual Exception? verify {
		value parameters= extractor();
			try{
				if(is Throwable result= reference(*parameters)){
					return Exception("Constrain not fullfilled for ``reference`` with parameters ``parameters``", result);
				}
			}catch(Throwable error){	
				return Exception("Constrain not fullfilled for ``reference`` with parameters ``parameters``", error);
			}
		return null;
	}
	string => "``reference``: ``extractor()```";
	
}