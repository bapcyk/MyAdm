"
I am a `kubectl exec -it <POD> df` command
"
Class {
	#name : #MyKubePodDfCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodDfCmd >> help [
	^ 'POD disk (mount points) usage'
]

{ #category : #initialization }
MyKubePodDfCmd >> initializeWithExec: anExec [
	"Initializes the command with the executor instance anExec"
	self
		initializeWithName: 'POD Disk'
		subCmds: #()
		exec: anExec
		parser: MyAlignedColumnsParser new
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubePodDfCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. anArgs first. 'df'. }

]

{ #category : #utilities }
MyKubePodDfCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
