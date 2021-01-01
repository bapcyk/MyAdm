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
		parser: MyPlainTextParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #utilities }
MyKubeSvcDetailsCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'get'. 'svc'. anArgs first. '-o'. 'yaml' }

]

{ #category : #utilities }
MyKubeSvcDetailsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
