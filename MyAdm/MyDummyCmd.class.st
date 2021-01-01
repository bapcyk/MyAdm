"
I am a dummy command for debug purposes
"
Class {
	#name : #MyDummyCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyDummyCmd >> help [
	^ 'Dummy command for debug only'
]

{ #category : #initialization }
MyDummyCmd >> initializeWithExec: anExec [

	self
		initializeWithName: 'Dummy'
		subCmds: #(  )
		exec: anExec "ignoring actually"
		parser: MyAlignedColumnsParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #utilities }
MyDummyCmd >> run: anArgs [
	"Runs command passed as arguments list. Returns the result as a WideString.
	It must form a command like #('ls' '/tmp') from anArgs like #('/tmp')
	"
	Transcript cr; show: anArgs.
	^ anArgs asString

]

{ #category : #utilities }
MyDummyCmd >> selectionAsArgs: aCmdName [
	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	| sel |
	sel := presenter selection.

	"If there is a selection, then it is a list of columns, so we return the first column - the name of the POD"
	^ sel ifNotNil: [ sel first ] ifNil: [ nil ]
]
