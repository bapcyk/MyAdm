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

{ #category : #testing }
MyKubeBase64Cmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount > 0
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
