"
I am a `kubectl exec -it <POD> ls -- -l <DIR>` command
"
Class {
	#name : #MyKubePodFsCmd,
	#superclass : #MyAbstractFSEntriesCmd,
	#category : #MyAdm
}

{ #category : #'changing state' }
MyKubePodFsCmd >> changeTopDir: aDirName [
	"Changes the top of the directories stack"
	| dirs |
	dirs := self dirs.
	dirs ifEmpty: [ dirs add: aDirName ] ifNotEmpty: [ dirs at: dirs size put: aDirName ].
]

{ #category : #accessing }
MyKubePodFsCmd >> dirString [
	"Returns the current dir as a full path string"
	| d |
	d := $/ join: self dirs.
	^ d ifEmpty: [ '/' ].
]

{ #category : #utilities }
MyKubePodFsCmd >> dirString: aNewDir [
	"Returns a new full path - a join of my dir stack and aNewDir"
	| d theNewDir |
	theNewDir := aNewDir trimBoth: [ :ch | ch = $/ ].
	d := $/ join: self dirs.
	^ d ifEmpty: [ '/', theNewDir ] ifNotEmpty: [ d, '/', theNewDir ].
]

{ #category : #accessing }
MyKubePodFsCmd >> dirs [
	"The current dirs stack in the context (#dir in the `context`)"
	^ context at: #dir ifAbsentPut: OrderedCollection new.
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
		subCmds: {
			self.
			MyKubeCatCmd newCmd: anExec.
			MyKubeCatUtf8Cmd newCmd: anExec.
			MyKubeGetFileCmd newCmd: anExec.
		}
		exec: anExec
		parser: (MyAlignedColumnsParser new margins: margins; header: header)
		presenter: MyTablePresenter

]

{ #category : #testing }
MyKubePodFsCmd >> isDirectorySelected [
	"Returns true if a one file is selected"
	| sel mode |
	sel := presenter selection.
	sel ifNil: [ ^ false ].
	mode := sel first first.
	"l... is treated as possible directory"
	^ (mode beginsWith: 'd') or: (mode beginsWith: 'l').
]

{ #category : #testing }
MyKubePodFsCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	aPresentCmd selectedCount = 1 ifFalse: [ ^ false ].
	^ (aPresentCmd isKindOf: MyAbstractFSEntriesCmd)
			ifTrue: [ aPresentCmd isDirectorySelected ]
			"if no way to detect what is selected, assume that it's directory since this button exists in the toolbar"
			ifFalse: true

]

{ #category : #testing }
MyKubePodFsCmd >> isFileSelected [
	"Returns true if a one file is selected"
	| sel mode |
	sel := presenter selection.
	sel ifNil: [ ^ false ].
	mode := sel first first.
	"l... is treated as possible file"
	^ (mode beginsWith: '-') or: (mode beginsWith: 'l').

]

{ #category : #'changing state' }
MyKubePodFsCmd >> pushDir: aDirName [
	"Pushes a new directory name to the dirs stack"
	self dirs add: aDirName
]

{ #category : #utilities }
MyKubePodFsCmd >> run: anArgs [
	| pod dir |
	pod := anArgs first.
	dir := anArgs second.
	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'ls'. '--'. '-l'. dir. })

]

{ #category : #running }
MyKubePodFsCmd >> runUI: anArgs [

	| clone dir |
	
	clone := self cloneMe.
	dir := anArgs second.
	dir = '/'
		ifTrue: [ self pushDir: '' ]
		ifFalse: 	[ self context at: #dir put: (dir splitOn: '/') ].
	extTitle := self dirString.
	self contextAt: #pod put: anArgs first.
	subCmds replace: [ :each | each class == self class ifTrue: [ clone ] ifFalse: [ each ] ].
	"subCmds replaceAll: self with: clone."
	^ super runUI: anArgs
]

{ #category : #utilities }
MyKubePodFsCmd >> selectionAsArgs: aCmdName [

	| sel fsEntry |
	sel := presenter selection.
	^ sel ifNotNil: [
		fsEntry := (sel at: 1) at: 9.
		fsEntry := (fsEntry splitOn: ' -> ') first. 
		{ self context at: #pod. self dirString: fsEntry }
	]
]
