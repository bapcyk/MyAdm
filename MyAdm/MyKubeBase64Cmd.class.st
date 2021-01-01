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

{ #category : #utilities }
MyKubeBase64Cmd >> run: anArgs [

	^ anArgs first first base64Decoded.

]

{ #category : #utilities }
MyKubeBase64Cmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
