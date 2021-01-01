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

	self
		initializeWithName: 'Services'
		subCmds: #()
		exec: anExec
		parser: MyAlignedColumnsParser
		presenter: MyTablePresenter
		withoutHeader: false
]

{ #category : #utilities }
MyWinServicesCmd >> run: anArgs [
	"Ignores all arguments because it does not require them"
	^ exec exec: 'Get-Service'

]

{ #category : #utilities }
MyWinServicesCmd >> selectionAsArgs: aCmdName [

	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	(sel isNil or: sel first isNil) ifTrue: [ ^ nil ].
	^ {sel first first}
]
