"
I am a `kubectl exec -it <POD> ip addr show` command
"
Class {
	#name : #MyKubePodIpCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodIpCmd >> help [
	^ 'Network interfaces'
]

{ #category : #initialization }
MyKubePodIpCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'IP'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubePodIpCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubePodIpCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'ip'. 'addr'. 'show'. })

]

{ #category : #utilities }
MyKubePodIpCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
