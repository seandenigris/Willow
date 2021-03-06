"
A DropDownListWebViewTest is a test class for testing the behavior of DropDownListWebView
"
Class {
	#name : #DropDownListWebViewTest,
	#superclass : #SingleSelectionWebViewTest,
	#category : 'Willow-Tests-WebViews'
}

{ #category : #support }
DropDownListWebViewTest >> newSingleSelectionView [

	^ DropDownListWebView applying: [  ]
]

{ #category : #'tests-configuring' }
DropDownListWebViewTest >> testIdentifyIn [

	| dropDownList html |

	dropDownList := self newSingleSelectionView.

	html := self
		renderUsing: [ :canvas | 
			dropDownList identifyIn: canvas.
			canvas render: dropDownList ].

	self
		assert: html equals: '<select name="2" id="drop-down-list-id1"></select>';
		assert: dropDownList identifier equals: 'drop-down-list-id1'
]

{ #category : #'tests-configuring' }
DropDownListWebViewTest >> testOnTrigger [

	| dropDownList html |

	dropDownList := self newSingleSelectionView.
	dropDownList onTrigger disable.

	html := self render: dropDownList.

	self assert: html equals: '<select name="1" id="select-id2"></select><script type="text/javascript">$("#select-id2").change(function(event){$(this).prop("disabled",true)});</script>'
]

{ #category : #'tests-rendering' }
DropDownListWebViewTest >> testRenderContentOn [

	| dropDownList html |

	dropDownList := self newSingleSelectionView.

	html := self render: dropDownList.

	self assert: html equals: '<select name="1"></select>'
]

{ #category : #'tests-rendering' }
DropDownListWebViewTest >> testRenderContentOnWithCommands [

	| dropDownList html |

	dropDownList := DropDownListWebView applying: [ :dropdown | dropdown addClass willow ].
	html := self render: dropDownList.

	self assert: html equals: '<select name="1" class="willow"></select>'
]

{ #category : #'tests-rendering' }
DropDownListWebViewTest >> testRenderContentOnWithElements [

	| dropDownList html |

	dropDownList := self newSingleSelectionView.
	dropDownList allowAnyOf: #('One' 'Two' 'Three').
	html := self render: dropDownList.

	self
		assert: html
		equals:
			'<select name="1" id="id2"><option value="1">One</option><option value="2">Two</option><option value="3">Three</option></select><script type="text/javascript">$("#id2").prop("selectedIndex",-1);</script>'
]

{ #category : #'tests-rendering' }
DropDownListWebViewTest >> testRenderContentOnWithElementsAndSomethingSelected [

	| dropDownList html |

	dropDownList := self newSingleSelectionView.
	dropDownList allowAnyOf: #('One' 'Two' 'Three').
	dropDownList chooseAnySatisfying: [ :element | true ] ifNone: [ self fail ].
	html := self render: dropDownList.

	self assert: html equals: '<select name="1"><option value="1" selected="selected">One</option><option value="2">Two</option><option value="3">Three</option></select>'
]
