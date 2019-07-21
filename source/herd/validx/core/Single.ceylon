import ceylon.language.meta.model {

	Function
}

shared class  Single<Parameters> satisfies Verification given Parameters satisfies Anything[] {

	shared Function<Anything,Parameters>reference; 
	Parameters() extractor;
	
	shared new (
		Function<Anything,Parameters> reference, 
		Parameters parameters
	){
		this.reference=reference;
		this.extractor=() => parameters;
	}
	
	shared new extracted(Function<Anything,Parameters>  reference, Parameters() extractor){
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