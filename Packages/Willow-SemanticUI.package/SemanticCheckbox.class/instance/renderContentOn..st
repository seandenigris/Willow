rendering
renderContentOn: aCanvas

	| containerComponent |

	containerComponent := self containerComponentOn: aCanvas.
	containerComponent
		with: [ | input |

			input := self inputRenderedOn: aCanvas.
			self renderLabelFor: input id on: aCanvas ]