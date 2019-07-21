import ceylon.test {
	test,
	assertThatException
}
import herd.validx {
	Single,
	Multi,
	validate,
	ValidationError
}

void throwing(String param) {
	throw Exception("INVALID ``param``");
}
void nonThrowing(String param) {}
shared test
void whenProvidedParams_then_shouldValidate() {
	validate {
		validations = {
			Single(`nonThrowing`, ["Abc"])
		};
	};
}

shared test
void whenProvidedParams_then_shouldInvalidate() {
	
	assertThatException {
		() => validate {
				validations = {
					Single(`throwing`, ["bleh"])
				};
			};
	}.hasType(`ValidationError`);
}

shared test
void whenProvidedThroughExtractor_then_shouldInvalidate() {
	assertThatException {
		() => validate {
				validations = {
					Single.extracted(`throwing`, () => ["bleh"])
				};
			};
	}.hasType(`ValidationError`);
}

shared test
void whenProvidedStream_then_shouldInvalidate() {
	
	assertThatException {
		() => validate {
			validations = {
				Multi(`throwing`, { ["bleh"], ["blah"] })
			};
		};
	}.hasType(`ValidationError`);
}

shared test
void whenProvidedStreamThroughExctractor_then_shouldInvalidate() {
	
	assertThatException {
		() => validate {
			validations = {
				Multi.extracted(`throwing`, () => { ["bleh"], ["blah"] })
			};
		};
	}.hasType(`ValidationError`);
}
shared test
void whenProvidedMixed_then_should_invalidate() {
	assertThatException {
		() => validate {
			validations = {
				Single(`nonThrowing`, ["blej"]),
				Multi(`throwing`, { ["bleh"], ["blah"] })
			};
		};
	}.hasType(`ValidationError`);
	
}
