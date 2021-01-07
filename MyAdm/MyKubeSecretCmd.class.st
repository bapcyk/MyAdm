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
	| header |
	header := #('ITEM' 'BASE64 VALUE').

	self
		initializeWithName: 'Get Secret'
		subCmds: { MyKubeBase64Cmd newCmd: anExec }
		exec: anExec
		parser: (MyJSONColumnsParser new zoomIn: 'data'; header: header)
		presenter: MyTablePresenter

]

{ #category : #testing }
MyKubeSecretCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSecretCmd >> run: anArgs [
	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'get'. 'secret'. anArgs first. '-o'. 'json' }).

]

{ #category : #running }
MyKubeSecretCmd >> runUI: anArgs [
	"arg1 - secret item; optional arg2 - pod"
	anArgs size = 2 ifTrue: [ self contextAt: #pod put: anArgs second ].
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeSecretCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [
		aCmdName = 'Decode Base64'
			ifTrue: [ { sel first second. sel first first. context at: #pod. } ]
			ifFalse: [ sel ]
	]
]
