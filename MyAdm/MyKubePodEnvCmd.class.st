"
I am a `kubectl exec -it <POD> env` command
"
Class {
	#name : #MyKubePodEnvCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodEnvCmd >> help [
	^ 'POD environment'
]

{ #category : #initialization }
MyKubePodEnvCmd >> initializeWithExec: anExec [
	"Initializes the command with the executor instance anExec"
	| header |
	header := #('NAME' 'VALUE').

	self
		initializeWithName: 'POD Environment'
		subCmds: #()
		exec: anExec
		parser: (MyRcParser new columnsDelim: $=; header: header)
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubePodEnvCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. anArgs first. 'env'. }

]

{ #category : #utilities }
MyKubePodEnvCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
