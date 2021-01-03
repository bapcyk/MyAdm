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
		'presenter',
		'context'
	],
	#category : #MyAdm
}

{ #category : #'instance creation' }
MyAbstractCmd class >> newCmd: anExec [
	"Factory for new command"
	^ self new initializeWithExec: anExec
]

{ #category : #creating }
MyAbstractCmd >> cloneMe [

	"Clones itself as a new object"

	| clone |
	clone := self class new
		         initializeWithName: name
		         subCmds: subCmds
		         exec: exec
		         parser: parser
		         presenter: presenterClass.
	clone context: context deepCopy.
	^ clone
]

{ #category : #accessing }
MyAbstractCmd >> context [

	^ context
]

{ #category : #accessing }
MyAbstractCmd >> context: anObject [

	context := anObject
]

{ #category : #accessing }
MyAbstractCmd >> contextAt: aKey put: aValue [
	"Puts aValue under the aKey. Returns self, not added aValue as a usual!!!"
	context at: aKey put: aValue
]

{ #category : #accessing }
MyAbstractCmd >> help [
	"Help string, should be overriden"
	^ name
]

{ #category : #initialization }
MyAbstractCmd >> initialize [
	context := Dictionary new.

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

{ #category : #accessing }
MyAbstractCmd >> requiredSelectionSize [
	"The size of the selection (string size, rows number, etc) which is required for the
	command to be allowed and relevant"
	^ 0
]

{ #category : #utilities }
MyAbstractCmd >> run: anArgs [
	"Runs command passed as arguments list. Returns the result as a WideString.
	It must form a command like #('ls' '/tmp') from anArgs like #('/tmp').
	Typical implementation is an execution with `exec`, but others are possible too.
	The implementation should not change the state of the command.
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
