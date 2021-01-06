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
		parser: (MyRcParser new columnsDelim: $*; header: header)
		presenter: MyTablePresenter

]

{ #category : #testing }
MyKubeSecretCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSecretCmd >> run: anArgs [
	| res lines |
	res := exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'get'. 'secret'. anArgs first. '-o'. 'json' }).
	res := STONJSON fromString: res.
	res := res at: #data.
	lines := OrderedCollection new.
	res keysAndValuesDo: [ :k :v |
		lines add: k asString, '*', v asString
	].
	^ Character lf join: lines.
]

{ #category : #utilities }
MyKubeSecretCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [
		aCmdName = 'Decode Base64'
			ifTrue: [ { sel first second } ]
			ifFalse: [ sel ]
	]
]
