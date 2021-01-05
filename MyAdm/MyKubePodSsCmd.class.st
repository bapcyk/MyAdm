"
I am a `kubectl exec -it <POD> ss` command
"
Class {
	#name : #MyKubePodSsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodSsCmd >> help [
	^ 'Sockets state'
]

{ #category : #initialization }
MyKubePodSsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Sockets'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubePodSsCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodSsCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'ss'. '--'. '-a'. '-p'. }

]

{ #category : #utilities }
MyKubePodSsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
