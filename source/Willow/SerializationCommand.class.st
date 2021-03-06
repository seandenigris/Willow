"
I'm a WebInteractionCommand that specifies how to serialize the component state.
"
Class {
	#name : #SerializationCommand,
	#superclass : #WebInteractionCommand,
	#instVars : [
		'priorityActions'
	],
	#category : #'Willow-WebInteraction'
}

{ #category : #'instance creation - private' }
SerializationCommand class >> executing: aPriorityAction [

	^self new initializeExecuting: aPriorityAction
]

{ #category : #'instance creation' }
SerializationCommand class >> forChildForm [

	^ self
		executing: [ :anAsynchronousCall :aCanvas | 
			anAsynchronousCall
				bePost;
				serialize: (aCanvas jQuery this children: 'form') ]
]

{ #category : #'instance creation' }
SerializationCommand class >> forCurrentObject [

	^ self
		executing: [ :anAsynchronousCall :aCanvas | 
			anAsynchronousCall
				bePost;
				serializeThis ]
]

{ #category : #'instance creation' }
SerializationCommand class >> forCurrentObjectWithHiddenInputs [

	^ self
		executing: [ :anAsynchronousCall :aCanvas | 
			anAsynchronousCall
				bePost;
				serializeThisWithHidden ]
]

{ #category : #'instance creation' }
SerializationCommand class >> forForm: anIdentifiedForm [

	^ self
		executing: [ :anAsynchronousCall :aCanvas | 
			anIdentifiedForm identifyIn: aCanvas.
			anAsynchronousCall
				bePost;
				serialize: (aCanvas jQuery id: anIdentifiedForm identifier) ]
]

{ #category : #'instance creation' }
SerializationCommand class >> forParentForm [

	^ self
		executing: [ :anAsynchronousCall :aCanvas | 
			anAsynchronousCall
				bePost;
				serializeForm ]
]

{ #category : #accessing }
SerializationCommand >> clientIndependentActions [

	^#()
]

{ #category : #'initialize-release' }
SerializationCommand >> initializeExecuting: aPriorityAction [

	priorityActions := Array with: aPriorityAction
]

{ #category : #accessing }
SerializationCommand >> modelLoadingActions [

	^#()
]

{ #category : #accessing }
SerializationCommand >> priorityActions [

	^priorityActions
]

{ #category : #testing }
SerializationCommand >> requiresSerialization [

	^false
]

{ #category : #accessing }
SerializationCommand >> serverIndependentActions [

	^#()
]
