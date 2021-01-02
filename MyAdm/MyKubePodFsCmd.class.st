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

	self
		initializeWithName: 'FS'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubePodFsCmd >> run: anArgs [
	| theFolder |
	theFolder := folder ifNil: [ anArgs at: 2 ] ifNotNil: [ folder ].
	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. anArgs first. 'ls'. '--'. '-l'. theFolder. }

]

{ #category : #utilities }
MyKubePodFsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a just selected text"
	^ sel ifNotNil: [ {sel} ] ifNil: [ nil ]
]
