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

{ #category : #testing }
MyKubeCatCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd isFileSelected
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
	| pod path |
	pod := anArgs first.
	path := anArgs second.
	extTitle := path.
	self contextAt: #pod put: pod.
	self contextAt: #path put: path.
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeCatCmd >> selectionAsArgs: aCmdName [
	| sel |

	aCmdName = 'Apply File' ifTrue: [
		^ { self context at: #pod. self context at: #path. presenter contents. }.
	].

	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
