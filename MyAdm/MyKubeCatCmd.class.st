"
I am a `kubectl exec -it <POD> cat <PATH>` command
"
Class {
	#name : #MyKubeCatCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeCatCmd >> help [
	^ 'File content'
]

{ #category : #initialization }
MyKubeCatCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Cat'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubeCatCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubeCatCmd >> run: anArgs [
	| pod path |
	pod := anArgs first.
	path := anArgs second.
	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. pod. 'cat'. path. }

]

{ #category : #running }
MyKubeCatCmd >> runUI: anArgs [
	extTitle := anArgs second.
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeCatCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
