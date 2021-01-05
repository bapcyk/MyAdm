"
I am a `kubectl get svc` command.
"
Class {
	#name : #MyKubeSvcCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSvcCmd >> help [
	^ 'Get current namespace services'
]

{ #category : #initialization }
MyKubeSvcCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'NS Services'
		subCmds: { MyKubeSvcDetailsCmd newCmd: anExec. MyKubeSvcEndpointsCmd newCmd: anExec. }
		exec: anExec
		parser: MyAlignedColumnsParser new
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubeSvcCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: (MyCmdArgs fromLine: '<REMOTE-BIN>/kubectl get svc')

]

{ #category : #utilities }
MyKubeSvcCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel first ]
]
