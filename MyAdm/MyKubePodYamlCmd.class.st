"
I am a `kubectl get pod <POD> -o yaml` command
"
Class {
	#name : #MyKubePodYamlCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodYamlCmd >> help [
	^ 'Get POD YAML'
]

{ #category : #initialization }
MyKubePodYamlCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'YAML'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubePodYamlCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'get'. 'pod'. anArgs first. '-o'. 'yaml' }

]

{ #category : #utilities }
MyKubePodYamlCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
