"
I am a `kubectl exec -it <POD> top -b -n 1` command
"
Class {
	#name : #MyKubePodTopCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubePodTopCmd >> help [
	^ 'Top Processes'
]

{ #category : #initialization }
MyKubePodTopCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Top'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubePodTopCmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubePodTopCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'top'. '--'. '-b'. '-n'. '1' })

]

{ #category : #utilities }
MyKubePodTopCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
