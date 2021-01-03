"
I am a command `Get-Service`.
"
Class {
	#name : #MyWinServicesCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyWinServicesCmd >> help [
	^ 'Get the list of services'
]

{ #category : #initialization }
MyWinServicesCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"
	| d1 d2 d3 |
	d1 := (MyDummyCmd newCmd: anExec) action: [:args| '!!!!']; name: 'D1'; requiredSelectionSize: 0.
	d2 := (MyDummyCmd newCmd: anExec) action: [:args| '?????']; name: 'D2'; requiredSelectionSize: 1.
	d3 := (MyDummyCmd newCmd: anExec) action: [:args| '??!!?']; name: 'D3';  requiredSelectionSize: 2.
	self
		initializeWithName: 'Services'
		subCmds: { d1. d2. d3. }
		exec: anExec
		parser: MyAlignedColumnsParser new
		presenter: MyTablePresenter

]

{ #category : #utilities }
MyWinServicesCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: 'Get-Service'

]

{ #category : #utilities }
MyWinServicesCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel first ]
]
