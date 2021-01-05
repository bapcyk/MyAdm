"
I am a `kubectl exec -it <POD> ip route show` command
"
Class {
	#name : #MyKubePodRouteCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodRouteCmd >> help [
	^ 'Routes'
]

{ #category : #initialization }
MyKubePodRouteCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Route'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubePodRouteCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodRouteCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'ip'. 'route'. 'show'. })

]

{ #category : #utilities }
MyKubePodRouteCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
