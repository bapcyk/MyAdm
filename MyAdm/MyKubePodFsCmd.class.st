"
I am a `kubectl exec -it <POD> ls -- -l <DIR>` command
"
Class {
	#name : #MyKubePodFsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #utilities }
MyKubePodFsCmd class >> joinPath: aPath1 to: aPath2 [
	^ aPath1 ifEmpty: [ aPath2 ]
	         ifNotEmpty: [
					aPath1 last = $/ ifTrue: [ aPath1, aPath2 ] ifFalse: [ aPath1, '/', aPath2 ] ]
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
		subCmds: { self }
		exec: anExec
		parser: (MyAlignedColumnsParser new margins: margins; header: header)
		presenter: MyTablePresenter

]

{ #category : #accessing }
MyKubePodFsCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubePodFsCmd >> run: anArgs [
	| pod dir |
	pod := anArgs first.
	dir := anArgs second.
	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. pod. 'ls'. '--'. '-l'. dir. }

]

{ #category : #running }
MyKubePodFsCmd >> runUI: anArgs [

	| clone dir dirStack |
	
	clone := self cloneMe.
	dirStack := clone context at: #dir ifAbsent: ''.
	dir := anArgs second.
	self context at: #dir put: (self class joinPath: dirStack to: dir).
	self context at: #pod put: anArgs first.
	subCmds replaceAll: self with: clone.
	Transcript show: anArgs; tab; show: context; cr.
	^ super runUI: anArgs
]

{ #category : #utilities }
MyKubePodFsCmd >> selectionAsArgs: aCmdName [

	| sel fsEntry |
	sel := presenter selection.
	^ sel ifNotNil: [
		fsEntry := (sel at: 1) at: 9.
		fsEntry := (fsEntry splitOn: ' -> ') first. 
		{ self context at: #pod. self class joinPath: (self context at: #dir) to: fsEntry }
	]
]
