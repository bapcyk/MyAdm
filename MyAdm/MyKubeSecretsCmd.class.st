"
I am a command `kubectl get secrets`
"
Class {
	#name : #MyKubeSecretsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSecretsCmd >> help [
	^ 'Get current namespace secrets'
]

{ #category : #initialization }
MyKubeSecretsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'NS Secrets'
		subCmds: {
			MyKubeDescribeSecretCmd newCmd: anExec.
			MyKubeSecretCmd newCmd: anExec.
			MyKubeSecretDetailsCmd newCmd: anExec.
		}
		exec: anExec
		parser: (MyAlignedColumnsParser new headerless: false)
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubeSecretsCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: '<REMOTE-BIN>/kubectl get secrets'

]

{ #category : #utilities }
MyKubeSecretsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
