Class {
	#name : #SetComponentSizeCommandTest,
	#superclass : #WARenderingTest,
	#category : 'Willow-Tests-Frontend'
}

{ #category : #'tests-processing' }
SetComponentSizeCommandTest >> testApplyToOn [
	| html |
	html := self apply: (SetComponentSizeCommand setting: 5) toComponentDefinedBy: [ :canvas | canvas select ].
	self assert: html equals: '<select size="5"></select>'
]
