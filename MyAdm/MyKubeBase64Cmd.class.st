"
I am a base64 decoder
"
Class {
	#name : #MyKubeBase64Cmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeBase64Cmd >> help [
	^ 'Decode selected text with Base64 decoder'
]

{ #category : #initialization }
MyKubeBase64Cmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Decode Base64'
		subCmds: #()
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubeBase64Cmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubeBase64Cmd >> run: anArgs [

	^ anArgs first base64Decoded.

]

{ #category : #utilities }
MyKubeBase64Cmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
