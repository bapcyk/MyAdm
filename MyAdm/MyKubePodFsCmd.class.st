"
I am a `kubectl exec -it <POD> ls -- -l <DIR>` command
"
Class {
	#name : #MyKubePodFsCmd,
	#superclass : #MyAbstractCmd,
	#instVars : [
		'folder'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodFsCmd >> folder [

	^ folder
]

{ #category : #accessing }
MyKubePodFsCmd >> folder: anObject [

	folder := anObject
]

{ #category : #accessing }
MyKubePodFsCmd >> help [
	^ 'Browse POD file system'
]

{ #category : #initialization }
MyKubePodFsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"
	| margins header |
	margins := MyParserMargins new topSize: 1.
	header := #( 'MODE' 'LN' 'USER' 'GRP' 'SIZE' 'MONTH' 'DAY' 'YEAR/TIME' 'NAME').
	
	self
		initializeWithName: 'File System'
		subCmds: {self} "{ MyKubePodFsCmd newCmd: anExec }"
		exec: anExec
		parser: (MyAlignedColumnsParser new margins: margins; header: header; yourself)
		presenter: MyTablePresenter

]

{ #category : #accessing }
MyKubePodFsCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodFsCmd >> run: anArgs [
	| theFolder |
	context at: #pod put: anArgs first.
	theFolder := folder ifNil: [ anArgs at: 2 ] ifNotNil: [ folder ].
	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. anArgs first. 'ls'. '--'. '-l'. theFolder. }

]

{ #category : #utilities }
MyKubePodFsCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel first ]
]
