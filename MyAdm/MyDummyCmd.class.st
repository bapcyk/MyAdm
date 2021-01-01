"
I am a dummy command for debug purposes
"
Class {
	#name : #MyDummyCmd,
	#superclass : #MyAbstractCmd,
	#instVars : [
		'action'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyDummyCmd >> action [

	^ action
]

{ #category : #accessing }
MyDummyCmd >> action: anObject [

	action := anObject
]

{ #category : #accessing }
MyDummyCmd >> help [
	^ 'Dummy command ', name, ' for debug only'
]

{ #category : #initialization }
MyDummyCmd >> initializeWithExec: anExec [

	self
		initializeWithName: 'Dummy'
		subCmds: #(  )
		exec: anExec "ignoring actually"
		parser: MyPlainTextParser
		presenter: MyTextPresenter
		withoutHeader: true
]

{ #category : #accessing }
MyDummyCmd >> name: aName [
	name := aName.
]

{ #category : #utilities }
MyDummyCmd >> run: anArgs [
	"If runAction is set then executes it otherwise returns anArgs as is"
	^ action ifNil: [ 	anArgs asString ] ifNotNil: [ action value: anArgs ].

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
