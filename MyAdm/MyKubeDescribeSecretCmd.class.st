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
		subCmds: #()
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubeDescribeSecretCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeDescribeSecretCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'describe'. 'secrets/', anArgs first })
]

{ #category : #utilities }
MyKubeDescribeSecretCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
