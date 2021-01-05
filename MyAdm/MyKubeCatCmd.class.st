"
I am a `kubectl exec -it <POD> cat <PATH>` command
"
Class {
	#name : #MyKubeCatCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeCatCmd >> help [
	^ 'File content'
]

{ #category : #initialization }
MyKubeCatCmd >> initializeWithExec: anExec [
	"Initializes the command with the executor instance anExec"
	| binExec theSubCmds |
	binExec := anExec shallowCopy.
	binExec encoding: nil.

	theSubCmds := OrderedCollection new.
	(anExec supports: #stdin) ifTrue: [ theSubCmds add: (MyKubeApplyFileCmd newCmd: binExec) ].

	self
		initializeWithName: 'Cat'
		subCmds: theSubCmds
		exec: binExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubeCatCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubeCatCmd >> run: anArgs [
	| pod path |
	pod := anArgs first.
	path := anArgs second.
	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'cat'. path. })

]

{ #category : #running }
MyKubeCatCmd >> runUI: anArgs [
	| path |
	path := anArgs second.
	extTitle := path.
	subCmds do: [ :cmd | cmd class = MyKubeApplyFileCmd ifTrue: [ cmd contextAt: #path put: path ] ].
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeCatCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
