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
		'context',
		'extTitle'
	],
	#classVars : [
		'app'
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
	app := MyApp new.

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

{ #category : #testing }
MyAbstractCmd >> isEnabledForSelection: aSelection [
	"Returns boolean flag is the command enbaled for this selection"
	^ true
]

{ #category : #accesing }
MyAbstractCmd >> name [
	^ name
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
	| parseFailed res |
	parseFailed := false.
	res := self run: anArgs.
	
	[ parser parse: res ] on: Error do: [ parseFailed := true ].
	parser data ifNil: [ parseFailed := true ].
	parseFailed ifTrue: [
		^ self inform: 'No valid data, just ''', (res trim truncateWithElipsisTo: 34), ''''
		].
	
	presenter := app newPresenter: presenterClass.
	presenter windowTitle: (extTitle ifNil: [ name ] ifNotNil: [ name, ': ', extTitle ]).
	presenter openWithSpec.
	presenter initializeWithParser: parser cmds: subCmds forCmd: self.
	presenter updatePresenter.
	^ res.
]

{ #category : #utilities }
MyAbstractCmd >> selectedCount [
	"Number of selected items"
	^ (presenter selection ifNil: #()) size.

]

{ #category : #utilities }
MyAbstractCmd >> selectionAsArgs: aCmdName [
	"Prepares arguments from the selected results item (table columns list) of this command
	for one of it's sub-command with a name aCmdName"

	self subclassResponsibility
]
