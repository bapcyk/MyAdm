"
I am a `kubectl get secret <SECRET> -o yaml` command
"
Class {
	#name : #MyKubeSecretDetailsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSecretDetailsCmd >> help [
	^ 'Details of the secret'
]

{ #category : #initialization }
MyKubeSecretDetailsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Secret Details'
		subCmds: { MyKubeBase64Cmd newCmd: anExec }
		exec: anExec
		parser: MyPlainTextParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #utilities }
MyKubeSecretDetailsCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'get'. 'secret'. anArgs first. '-o'. 'yaml' }
]

{ #category : #utilities }
MyKubeSecretDetailsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
