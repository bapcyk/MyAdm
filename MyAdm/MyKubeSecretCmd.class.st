"
I am a `kubectl get secret <SECRET> -o jsonpath={.data}` command
"
Class {
	#name : #MyKubeSecretCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSecretCmd >> help [
	^ 'Get secret'
]

{ #category : #initialization }
MyKubeSecretCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Get Secret'
		subCmds: { MyKubeBase64Cmd newCmd: anExec }
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubeSecretCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'get'. 'secret'. anArgs first. '-o'. 'jsonpath=''{.data}''' }
]

{ #category : #utilities }
MyKubeSecretCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
