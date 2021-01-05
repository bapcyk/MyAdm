Class {
	#name : #MyKubeApplyFileCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeApplyFileCmd >> help [
	^ 'Apply Edited File'
]

{ #category : #initialization }
MyKubeApplyFileCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Apply File'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubeApplyFileCmd >> run: anArgs [

	^ exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. anArgs first. 'ip'. 'addr'. 'show'. })

]

{ #category : #utilities }
MyKubeApplyFileCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
