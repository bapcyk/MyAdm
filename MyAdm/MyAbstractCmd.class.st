"
I am an abstract command - a composition of a presenter, an executor, a parser.
"
Class {
	#name : #MyAbstractCmd,
	#superclass : #Object,
	#instVars : [
		'name',
		'subCmds',
		'exec',
		'parser',
		'presenterClass',
		'presenter'
	],
	#category : #MyAdm
}

{ #category : #'instance creation' }
MyAbstractCmd class >> newCmd: anExec [
	"Factory for new command"
	^ self new initializeWithExec: anExec
]

{ #category : #accessing }
MyAbstractCmd >> help [
	"Help string, should be overriden"
	^ name
]

{ #category : #initialization }
MyAbstractCmd >> initializeWithExec: anExec [
	"Initialization with some executor"
			
	self subclassResponsibility
]

{ #category : #initialization }
MyAbstractCmd >> initializeWithName: aName subCmds: aCmds exec: anExec parser: aParser presenter: aPresenter [
	"Initializer"
	name := aName.
	subCmds := aCmds.
	exec := anExec.
	parser := aParser.
	presenterClass := aPresenter.


]

{ #category : #accesing }
MyAbstractCmd >> name [
	^ name
]

{ #category : #utilities }
MyAbstractCmd >> run: anArgs [
	"Runs command passed as arguments list. Returns the result as a WideString.
	It must form a command like #('ls' '/tmp') from anArgs like #('/tmp')
	"
	self subclassResponsibility

]

{ #category : #running }
MyAbstractCmd >> runUI: anArgs [
	"The same as run method but returns the result in UI"
	| res |
	res := self run: anArgs.
	parser parse: res.
	presenter := presenterClass new.
	presenter windowTitle: name.
	presenter openWithSpec.
	presenter initializeWithParser: parser cmds: subCmds forCmd: self.
	presenter updatePresenter.
]

{ #category : #utilities }
MyAbstractCmd >> selectionAsArgs: aCmdName [
	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	self subclassResponsibility
]
