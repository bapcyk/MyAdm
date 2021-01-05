"
I am an abstract executor of string commands
"
Class {
	#name : #MyAbstractExec,
	#superclass : #Object,
	#instVars : [
		'quote',
		'vars',
		'encoding'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyAbstractExec class >> quoteArg: anArg [
	"Quotes anArg when it's required"
	
	^ (anArg includesAny: {Character space. Character tab})
		ifTrue: [ '"' , anArg , '"' ]
		ifFalse: anArg.
]

{ #category : #converting }
MyAbstractExec >> decode: aString [
	^ encoding ifNil: [ aString ] ifNotNil: [ aString convertFromEncoding: encoding ].
]

{ #category : #converting }
MyAbstractExec >> encode: aString [
	"Encodes aString if encoding is enabled"
	^ encoding ifNil: [ aString ] ifNotNil: [ aString convertToEncoding: encoding ].
]

{ #category : #accessing }
MyAbstractExec >> encoding [

	^ encoding
]

{ #category : #accessing }
MyAbstractExec >> encoding: anObject [

	encoding := anObject
]

{ #category : #utilities }
MyAbstractExec >> exec: aCmdArgs [
	"Executes a list of arguments or a string command.
	XXX THIS MESSAGE MUST BE USED TO EXECUTE SOMETHING"
	| argsAsString |
	argsAsString := [ (aCmdArgs processArgs: [ :arg | self quoteArgIfNeeded: (self substVars: arg) ]) joinUsing: ' ' ].

	aCmdArgs isString
		ifTrue: [ aCmdArgs processArg: [ :arg | self substVars: arg ] ]
		ifFalse: [ argsAsString value ].

	aCmdArgs processLine: [ :line | self encode: line ].
	^ self decode: (self operate: aCmdArgs).
]

{ #category : #initialization }
MyAbstractExec >> initialize [
	quote := true.
	vars := Dictionary new.
	encoding := 'utf-8'.

]

{ #category : #abstract }
MyAbstractExec >> operate: aString [
	"Successors implementation: executes command line, returns WideString"
	self subclassResponsibility
]

{ #category : #accessing }
MyAbstractExec >> quote [

	^ quote
]

{ #category : #accessing }
MyAbstractExec >> quote: anObject [

	quote := anObject
]

{ #category : #utilities }
MyAbstractExec >> quoteArgIfNeeded: anArg [
	"Quotes an argument if it's needed"
	| alreadyQuoted quoteNeeded |

	alreadyQuoted := (anArg beginsWith: '''') or: (anArg beginsWith: '"').
	quoteNeeded := quote and: (alreadyQuoted not).

	^ quoteNeeded ifTrue: [ self class quoteArg: anArg ] ifFalse: [ anArg ].

]

{ #category : #utilities }
MyAbstractExec >> substVars: aString [

	"Substitutes vars in the string"
	
	| s |
	s := aString.

	vars keysAndValuesDo: [ :k :v | s := s copyReplaceAll: '<', k, '>' with: v ].
	^ s.
]

{ #category : #classification }
MyAbstractExec >> supports: aFeature [
	"Returns is aFeature (string) is supported by the concrete executor"
	^ false
]

{ #category : #accessing }
MyAbstractExec >> vars [
	"Something like environment: <XXX> in args/command line will be substituted with #XXX item in vars"
	^ vars
]

{ #category : #accessing }
MyAbstractExec >> vars: anObject [

	vars := anObject
]
