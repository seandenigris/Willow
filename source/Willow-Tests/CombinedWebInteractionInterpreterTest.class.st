"
A CombinedWebInteractionInterpreterTest is a test class for testing the behavior of CombinedWebInteractionInterpreter
"
Class {
	#name : #CombinedWebInteractionInterpreterTest,
	#superclass : #WARenderingTest,
	#instVars : [
		'okButton',
		'cancelButton'
	],
	#pools : [
		'Willow'
	],
	#category : #'Willow-Tests-WebInteraction'
}

{ #category : #initialization }
CombinedWebInteractionInterpreterTest >> buttons [

	^ {okButton.
	cancelButton}
]

{ #category : #initialization }
CombinedWebInteractionInterpreterTest >> setUp [

	super setUp.
	okButton := AsynchronicButtonWebView labeled: 'Ok'.
	cancelButton := AsynchronicButtonWebView labeled: 'Cancel'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testAddCssClass [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	interpreter addCssClass: Classification >> #willow.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals: '<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).addClass("willow")});$("#button-id2").click(function(event){$(this).addClass("willow")});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testAddCssClassToComponentsMatching [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	interpreter addCssClass: Classification >> #willow toComponentsMatching: [ :canvas | canvas jQuery this ].
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).addClass("willow")});$("#button-id2").click(function(event){$(this).addClass("willow")});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testChangeCssClassTo [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter changeCssClass: Classification >> #loading to: Classification >> #willow.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(".willow-loading").removeClass("willow-loading").addClass("willow")});$("#button-id2").click(function(event){$(".willow-loading").removeClass("willow-loading").addClass("willow")});</script>'
]

{ #category : #'tests-Configuring - Dialogs' }
CombinedWebInteractionInterpreterTest >> testCloseAllDialogs [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter closeAllDialogs.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].

	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring - Dialogs' }
CombinedWebInteractionInterpreterTest >> testCloseLastDialog [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter closeLastDialog.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].

	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testConfirmAsking [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter confirmAsking: 'Continue?'.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){if(confirm("Continue?")){Willow.callServer({"url":"/","data":"1"})}});$("#button-id4").click(function(event){if(confirm("Continue?")){Willow.callServer({"url":"/","data":"3"})}});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testDetermineBehaviorByEvaluating [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter determineBehaviorByEvaluating: [  ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testDetermineBehaviorByEvaluatingWith [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter determineBehaviorByEvaluating: [  ] with: 'theClientParameter'.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id3" type="button">Ok</button><button id="button-id6" type="button">Cancel</button><script type="text/javascript">$("#button-id3").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1","2="+encodeURIComponent(JSON.stringify("theClientParameter"))].join("&")})});$("#button-id6").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["4","5="+encodeURIComponent(JSON.stringify("theClientParameter"))].join("&")})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testDisable [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	html := self
		renderUsing: [ :canvas | 
			interpreter disable.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).prop("disabled",true)});$("#button-id2").click(function(event){$(this).prop("disabled",true)});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testEnable [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter enable: textInput.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$("#15").prop("disabled",false)});$("#button-id2").click(function(event){$("#15").prop("disabled",false)});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testEvaluate [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter evaluate: [  ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testEvaluateWith [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter evaluate: [ :arguments | arguments ] with: #(firstThing secondStuff).

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id3" type="button">Ok</button><button id="button-id6" type="button">Cancel</button><script type="text/javascript">$("#button-id3").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1","2="+encodeURIComponent(JSON.stringify(["firstThing","secondStuff"]))].join("&")})});$("#button-id6").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["4","5="+encodeURIComponent(JSON.stringify(["firstThing","secondStuff"]))].join("&")})});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testExecuteOnClient [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter executeOnClient: [ :script :canvas | script << (JSStream on: 'window') call: 'print' ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){window.print()});$("#button-id2").click(function(event){window.print()});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testFocus [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter focus: textInput.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testFocusUsing [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter focusUsing: [ :canvas | canvas jQuery this ].
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testInform [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter inform: 'A message'.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){alert("A message")});$("#button-id2").click(function(event){alert("A message")});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testInformSelection [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter informSelection.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){alert($(this).children("option:selected").text())});$("#button-id2").click(function(event){alert($(this).children("option:selected").text())});</script>'
]

{ #category : #'tests-Configuring' }
CombinedWebInteractionInterpreterTest >> testOnlyWhenDetermineBehaviorByEvaluating [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter onlyWhen: '<1s> != null' determineBehaviorByEvaluating: [  ] with: 'theClientParameter'.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id3" type="button">Ok</button><button id="button-id6" type="button">Cancel</button><script type="text/javascript">$("#button-id3").click(function(event){if("theClientParameter" != null){Willow.callServer({"type":"POST","url":"/","data":["1","2="+encodeURIComponent(JSON.stringify("theClientParameter"))].join("&")})}});$("#button-id6").click(function(event){if("theClientParameter" != null){Willow.callServer({"type":"POST","url":"/","data":["4","5="+encodeURIComponent(JSON.stringify("theClientParameter"))].join("&")})}});</script>'
]

{ #category : #'tests-Configuring - Dialogs' }
CombinedWebInteractionInterpreterTest >> testOpen [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter open: [ :canvas | canvas dialog attributeAt: 'open' put: true ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].

	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testRemove [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter remove: textInput.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testRemoveCssClassFromComponentsMatching [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter removeCssClass: Classification >> #loading fromComponentsMatching: [ :canvas | canvas jQuery this ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).removeClass("willow-loading")});$("#button-id2").click(function(event){$(this).removeClass("willow-loading")});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testRemoveCssClassFromComponentsWithClass [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter removeCssClass: Classification >> #loading fromComponentsWithClass: Classification >> #willow.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(".willow").removeClass("willow-loading")});$("#button-id2").click(function(event){$(".willow").removeClass("willow-loading")});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testRender [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter render: textInput.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testRenderAll [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter renderAll: {textInput}.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testScrollingIntoView [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.
	interpreter scrollingIntoView: id.
	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSerializeChildForm [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter serializeChildForm.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1",$(this).children("form").serialize()].join("&")})});$("#button-id4").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["3",$(this).children("form").serialize()].join("&")})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSerializeContainerForm [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter
		combiningInterpretersOf:
			{okButton.
			cancelButton}.

	interpreter serializeContainerForm.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1",$(this).closest("form").find(":input").serialize()].join("&")})});$("#button-id4").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["3",$(this).closest("form").find(":input").serialize()].join("&")})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSerializeForm [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.


	html := self
		renderUsing: [ :canvas | 
			| form |

			form := canvas form.
			form id: 'id15'.

			interpreter serializeForm: form.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<form accept-charset="utf-8" method="post" action="/" id="id15"></form><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1",$("#id15").serialize()].join("&")})});$("#button-id4").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["3",$("#id15").serialize()].join("&")})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSerializeIt [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter serializeIt.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1",$(this).serialize()].join("&")})});$("#button-id4").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["3",$(this).serialize()].join("&")})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSerializeWithHiddenInputs [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter serializeWithHiddenInputs.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["1",$(this).next("input:hidden").addBack().serialize()].join("&")})});$("#button-id4").click(function(event){Willow.callServer({"type":"POST","url":"/","data":["3",$(this).next("input:hidden").addBack().serialize()].join("&")})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testSetValueToThenTriggerChangeOf [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.


	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput id: id.
			interpreter setValueTo: [ 'Ok' ] thenTriggerChangeOf: textInput.

			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testSetValueToWithoutTriggeringChangeOnComponentWithId [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	interpreter setValueTo: [ 'Ok' ] withoutTriggeringChangeOnComponentWithId: id.

	html := self
		renderUsing: [ :canvas | 
			canvas textInput id: id.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testShowLoadingNotificationStyledAsAll [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter showLoadingNotificationStyledAsAll: #().
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){$("#willow-notification-section").html("<div>Loading...</div>");Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){$("#willow-notification-section").html("<div>Loading...</div>");Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testShowWhileCallingServerToRender [

	| html interpreter container |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	container := IdentifiedWebView forDivNamed: 'search-results' containing: ''.

	html := self
		renderUsing: [ :canvas | 
			interpreter show: 'Loading...' whileCallingServerToRender: container.
			canvas
				render: okButton;
				render: cancelButton;
				render: container ].

	self
		assert: html
		equals:
			'<button id="button-id3" type="button">Ok</button><button id="button-id5" type="button">Cancel</button><div id="search-results-id1"></div><script type="text/javascript">$("#button-id3").click(function(event){$("#search-results-id1").html("Loading...");Willow.callServer({"url":"/","data":"2"})});$("#button-id5").click(function(event){$("#search-results-id1").html("Loading...");Willow.callServer({"url":"/","data":"4"})});</script>'
]

{ #category : #'tests-Configuring - Serialization' }
CombinedWebInteractionInterpreterTest >> testSubmitForm [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| form |

			form := canvas form.
			form id: id.
			interpreter submitForm: form.
			canvas
				render: okButton;
				render: cancelButton ].

	self
		assert: html
		equals:
			'<form accept-charset="utf-8" method="post" action="/" id="15"></form><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testSubmitFormStyledAs [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter submitFormStyledAs: Classification >> #willow.
	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){Willow.callServer({"url":"/","data":"1"})});$("#button-id4").click(function(event){Willow.callServer({"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testTemporarilyDisableAndTransformInto [

	| interpreter html id |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	id := '15'.

	html := self
		renderUsing: [ :canvas | 
			| textInput |

			textInput := canvas textInput.
			textInput id: id.
			interpreter temporarilyDisableAndTransform: textInput into: 'Loading...'.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<input id="15" type="text"/><button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){disabledComponent=$("#15").html();$("#15").addClass("willow-disabled-component").attr("disabled",true).html("Loading...");Willow.callServer({"complete":function(){$(".willow-disabled-component").attr("disabled",false).removeClass("willow-disabled-component").html(disabledComponent)},"url":"/","data":"1"})});$("#button-id4").click(function(event){disabledComponent=$("#15").html();$("#15").addClass("willow-disabled-component").attr("disabled",true).html("Loading...");Willow.callServer({"complete":function(){$(".willow-disabled-component").attr("disabled",false).removeClass("willow-disabled-component").html(disabledComponent)},"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testTemporarilyDisableAndTransformSelfInto [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	html := self
		renderUsing: [ :canvas | 
			interpreter temporarilyDisableAndTransformInto: 'Loading...'.
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id4" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){disabledComponent=$(this).html();$(this).addClass("willow-disabled-component").attr("disabled",true).html("Loading...");Willow.callServer({"complete":function(){$(".willow-disabled-component").attr("disabled",false).removeClass("willow-disabled-component").html(disabledComponent)},"url":"/","data":"1"})});$("#button-id4").click(function(event){disabledComponent=$(this).html();$(this).addClass("willow-disabled-component").attr("disabled",true).html("Loading...");Willow.callServer({"complete":function(){$(".willow-disabled-component").attr("disabled",false).removeClass("willow-disabled-component").html(disabledComponent)},"url":"/","data":"3"})});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testToggleCssClass [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter toggleCssClass: Classification >> #loading.

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).toggleClass("willow-loading")});$("#button-id2").click(function(event){$(this).toggleClass("willow-loading")});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testToggleCssClassOn [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter toggleCssClass: Classification >> #willow on: (IdentifiedWebView forDivNamed: 'example' containing: [  ]).


	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id3" type="button">Cancel</button><script type="text/javascript">$("#button-id2").click(function(event){$("#example-id1").toggleClass("willow")});$("#button-id3").click(function(event){$("#example-id1").toggleClass("willow")});</script>'
]

{ #category : #'tests-Configuring - CSS' }
CombinedWebInteractionInterpreterTest >> testToggleCssClassOnComponentsMatching [

	| interpreter html |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.

	interpreter toggleCssClass: Classification >> #loading onComponentsMatching: [ :canvas | canvas jQuery this ].

	html := self
		renderUsing: [ :canvas | 
			canvas
				render: okButton;
				render: cancelButton ].
	self
		assert: html
		equals:
			'<button id="button-id1" type="button">Ok</button><button id="button-id2" type="button">Cancel</button><script type="text/javascript">$("#button-id1").click(function(event){$(this).toggleClass("willow-loading")});$("#button-id2").click(function(event){$(this).toggleClass("willow-loading")});</script>'
]

{ #category : #'tests-Configuring-DOM' }
CombinedWebInteractionInterpreterTest >> testTransformInto [

	| html interpreter container |

	interpreter := CombinedWebInteractionInterpreter combiningInterpretersOf: self buttons.
	container := IdentifiedWebView forDivNamed: 'search-results' containing: ''.

	html := self
		renderUsing: [ :canvas | 
			interpreter transform: container into: 'Loading...'.
			canvas
				render: okButton;
				render: cancelButton;
				render: container ].

	self
		assert: html
		equals:
			'<button id="button-id2" type="button">Ok</button><button id="button-id3" type="button">Cancel</button><div id="search-results-id1"></div><script type="text/javascript">$("#button-id2").click(function(event){$("#search-results-id1").html("Loading...")});$("#button-id3").click(function(event){$("#search-results-id1").html("Loading...")});</script>'
]
