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

{ #category : #accessing }
MyKubePodDfCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodDfCmd >> run: anArgs [

	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. anArgs first. 'df'. }

]

{ #category : #utilities }
MyKubePodDfCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel first ]
]
