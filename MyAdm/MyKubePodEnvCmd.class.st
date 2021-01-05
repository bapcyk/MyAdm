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

{ #category : #accessing }
MyKubePodEnvCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodEnvCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'env'. })

]

{ #category : #utilities }
MyKubePodEnvCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel first ]
]
