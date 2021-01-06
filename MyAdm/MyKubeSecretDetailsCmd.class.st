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
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubeSecretDetailsCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSecretDetailsCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'get'. 'secret'. anArgs first. '-o'. 'yaml' })
]

{ #category : #utilities }
MyKubeSecretDetailsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
