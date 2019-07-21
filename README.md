# Validx
Simple validation framework using function references to execute validation process. Executed using `validate` function which throws a `ValidationError` or passing with no result. The process executes all validation, even when first fails, allowing to extract all results from provided `ValidationError`,
	through `ValidationError.errors`. 
	
Example:
```ceylon	
  void someValidation(String param) {
    throw Exception(\"INVALID \`\`param\`\`\");
  }

  validate {
    validations = {
      Single(\`someValidation`, [\"Abc\"])
    };
  };
```
`validate` has thrown and whenever caught result can be extracted and furtherly exposed to the user.
