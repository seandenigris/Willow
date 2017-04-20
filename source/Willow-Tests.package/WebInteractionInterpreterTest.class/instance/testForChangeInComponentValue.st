test - instance creation
testForChangeInComponentValue

	| interpreter html |

	interpreter := WebInteractionInterpreter forChangeInComponentValue.
	interpreter evaluate: [  ].
	html := self configureTextInputWith: interpreter.
	self
		assert: html
		equals:
			'<input id="input-id2" type="text"/><script type="text/javascript">$("#input-id2").change(function(){$.ajax({"url":"/","data":["1",$(this).serialize()].join("&"),"dataType":"script","error":Willow.handleAjaxErrorCall})});</script>'