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
		parser: MyPlainTextParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #utilities }
MyKubeSvcEndpointsCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'get'. 'endpoints'. anArgs first. '-o'. 'yaml' }

]

{ #category : #utilities }
MyKubeSvcEndpointsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
