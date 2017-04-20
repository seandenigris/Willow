tests-Configuring-DOM
testSerializeWithHiddenInputs

	| interpreter html id |

	interpreter := WebInteractionInterpreter forChangeInComponentValue.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter serializeWithHiddenInputs.
			interpreter applyTo: textInput on: canvas ].

	self
		assert: html
		equals:
			'<input id="15" type="text"/><script type="text/javascript">$("#15").change(function(){$.ajax({"url":"/","data":["1",$(this).next("input:hidden").addBack().serialize()].join("&"),"dataType":"script","error":Willow.handleAjaxErrorCall})});</script>'