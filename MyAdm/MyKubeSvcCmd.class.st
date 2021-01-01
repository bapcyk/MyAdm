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
		parser: (MyAlignedColumnsParser new headerless: false)
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubeSvcCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: '<REMOTE-BIN>/kubectl get svc'

]

{ #category : #utilities }
MyKubeSvcCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
