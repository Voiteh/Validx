import ceylon.test {
	test
}
import herd.validx.core {

	Validx,
	Single,
	Multi
}

void throwing(String param){
	throw Exception("INVALID ``param``");
}

void nonThrowing(String param){}

shared test void whenProvidedParams_then_shouldValidate(){
	value validate = Validx{
		verifications = {
			Single(`nonThrowing`,["Abc"])
		};
	}.validate;
	assert(!validate exists);
}

shared test void whenProvidedParams_then_shouldInvalidate(){

 	assert (exists validate = Validx{
		verifications = {
			Single(`throwing`,["bleh"])
		};
	}.validate);
	assert(exists error=validate.errors.first);
}

shared test void whenProvidedThroughExtractor_then_shouldInvalidate(){
	
	assert (exists validate = Validx{
		verifications = {
			Single.extracted(`throwing`,()=>["bleh"])
			
		};
	}.validate);
	assert(exists error=validate.errors.first);
}

shared test void whenProvidedStream_then_shouldInvalidate(){
	
	assert (exists validate = Validx{
		verifications = {
			Multi(`throwing`,{["bleh"],["blah"]})	
		};
	}.validate);
	assert(exists error=validate.errors.first);
}

shared test void whenProvidedStreamThroughExctractor_then_shouldInvalidate(){
	
	assert (exists validate = Validx{
		verifications = {
			Multi.extracted(`throwing`,()=>{["bleh"],["blah"]})
			
		};
	}.validate);
	assert(validate.errors.first exists);
	assert(validate.errors.rest.first exists);
}
shared test void whenProvidedMixed_then_should_invalidate(){
	assert (exists validate = Validx{
		verifications = {
			Single(`nonThrowing`, ["blej"]),
			Multi(`throwing`,{["bleh"],["blah"]})
		};
	}.validate);
	assert(validate.errors.first exists);
	assert(validate.errors.rest.first exists);
}

