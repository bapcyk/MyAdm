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
				MyKubePodFsCmd newCmd: anExec.
				MyKubePodEnvCmd newCmd: anExec.
				MyKubePodDfCmd newCmd: anExec.
				MyKubePodTopCmd newCmd: anExec.
				MyKubePodIpCmd newCmd: anExec.
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
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [
		aCmdName = 'File System'
			ifTrue: [ { sel first first. '/' } ]
			ifFalse: [ sel first ]
	]
]
