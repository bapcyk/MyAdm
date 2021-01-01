"
I am a `kubectl describe pod <POD>` command
"
Class {
	#name : #MyKubeDescribePodCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeDescribePodCmd >> help [
	^ 'Describe POD'
]

{ #category : #initialization }
MyKubeDescribePodCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Describe POD'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubeDescribePodCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'describe'. 'pod'. anArgs first. }

]

{ #category : #utilities }
MyKubeDescribePodCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
