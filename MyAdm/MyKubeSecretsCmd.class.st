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
		parser: MyAlignedColumnsParser new
		presenter: MyTablePresenter

]

{ #category : #testing }
MyKubeSecretsCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSecretsCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: (MyCmdArgs fromLine: '<REMOTE-BIN>/kubectl get secrets')

]

{ #category : #running }
MyKubeSecretsCmd >> runUI: anArgs [
	self contextAt: #pod put: anArgs first.
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeSecretsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [
		aCmdName = 'Get Secret'
			ifTrue: [ { sel first first. context at: #pod } ]
			ifFalse: [ sel first ].
	]
]
