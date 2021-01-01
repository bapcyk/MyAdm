"
I am a `kubectl describe secrets/<SECRET>` command
"
Class {
	#name : #MyKubeDescribeSecretCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeDescribeSecretCmd >> help [
	^ 'Describe secret'
]

{ #category : #initialization }
MyKubeDescribeSecretCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Describe Secret'
		subCmds: { MyKubeBase64Cmd newCmd: anExec }
		exec: anExec
		parser: MyPlainTextParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #utilities }
MyKubeDescribeSecretCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'describe'. 'secrets/', anArgs first }
]

{ #category : #utilities }
MyKubeDescribeSecretCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
