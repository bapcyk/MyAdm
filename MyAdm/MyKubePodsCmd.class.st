"
I am a command 'kubectl get pod'
"
Class {
	#name : #MyKubePodsCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodsCmd >> help [
	^ 'Get current namespace PODs'
]

{ #category : #initialization }
MyKubePodsCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'NS PODs'
		subCmds: { 
				(MyKubePodFsCmd newCmd: anExec) folder: '/'.
				MyKubePodEnvCmd newCmd: anExec.
				MyKubePodDfCmd newCmd: anExec.				
				MyKubePodYamlCmd newCmd: anExec.
				MyKubeSvcCmd newCmd: anExec.
				MyKubeSecretsCmd newCmd: anExec.
				MyKubeDescribePodCmd newCmd: anExec.
		}
		exec: anExec
		parser: MyAlignedColumnsParser new
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyKubePodsCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: '<REMOTE-BIN>/kubectl get pod'

]

{ #category : #utilities }
MyKubePodsCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
