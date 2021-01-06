"
I am a `kubectl get endpoints <SERVICE> -o yaml` command.
"
Class {
	#name : #MyKubeSvcEndpointsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSvcEndpointsCmd >> help [
	^ 'Get the service endpoints'
]

{ #category : #initialization }
MyKubeSvcEndpointsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Service Endpoints'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubeSvcEndpointsCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSvcEndpointsCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'get'. 'endpoints'. anArgs first. '-o'. 'yaml' })

]

{ #category : #utilities }
MyKubeSvcEndpointsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
