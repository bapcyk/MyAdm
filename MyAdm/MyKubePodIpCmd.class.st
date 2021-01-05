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

{ #category : #accessing }
MyKubePodIpCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodIpCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'ip'. 'addr'. 'show'. }

]

{ #category : #utilities }
MyKubePodIpCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
