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
		subCmds: {
			MyKubePodFsCmd newCmd: anExec.
		}
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

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'df'. })

]

{ #category : #running }
MyKubePodDfCmd >> runUI: anArgs [
	self context at: #pod put: anArgs first.
	^ super runUI: anArgs
]

{ #category : #utilities }
MyKubePodDfCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [
		aCmdName = 'File System'
			ifTrue: [ { self context at: #pod. sel first at: 6 } ]
			ifFalse: [ sel first ]
	]
]
