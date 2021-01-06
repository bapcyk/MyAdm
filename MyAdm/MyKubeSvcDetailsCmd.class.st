"
I am a `kubectl get svc <SERVICE> -o yaml` command.
"
Class {
	#name : #MyKubeSvcDetailsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSvcDetailsCmd >> help [
	^ 'Get the service details'
]

{ #category : #initialization }
MyKubeSvcDetailsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Service Details'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubeSvcDetailsCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSvcDetailsCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'get'. 'svc'. anArgs first. '-o'. 'yaml' })

]

{ #category : #utilities }
MyKubeSvcDetailsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
