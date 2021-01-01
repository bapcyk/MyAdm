"
I am an abstract executor of string commands
"
Class {
	#name : #MyAbstractExec,
	#superclass : #Object,
	#instVars : [
		'quote',
		'vars'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyAbstractExec class >> quoteArg: anArg [

	"Quotes anArg when it's required"

	^ (anArg includesAny: {Character space. Character tab})
		  ifTrue: [ '"' , anArg , '"' ]
		  ifFalse: anArg
]

{ #category : #utilities }
MyAbstractExec >> argsAsString: anArgs [

	"Converts anArgs to a string"

	| condQuote |
	condQuote := quote ifTrue: [ [ :s | self class quoteArg: s ] ] ifFalse: [ [ :s | s ] ].
	^ (anArgs collect: [ :arg |
		   condQuote value:
			   (arg copyWithRegex: '"' matchesReplacedWith: '\"') ]) 
		  joinUsing: ' '
]

{ #category : #utilities }
MyAbstractExec >> exec: aCmd [

	"Executes a list of arguments or a string command"

	^ aCmd isString
		  ifTrue: [ self execString: (self substVars: aCmd) ]
		  ifFalse: [ 
		  self execArgs: (aCmd collect: [ :c | self substVars: c ]) ]
]

{ #category : #utilities }
MyAbstractExec >> execArgs: anArgs [
	"Executes a command represented as a list"
	^ self execString: (self argsAsString: anArgs)
]

{ #category : #abstract }
MyAbstractExec >> execString: aString [
	"Executes command, returns WideString"
	self subclassResponsibility
]

{ #category : #initialization }
MyAbstractExec >> initialize [
	quote := true.
	vars := Dictionary new.

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
MyAbstractExec >> substVars: aString [

	"Substitutes vars in the string"
	
	| s |
	s := aString.

	vars keysAndValuesDo: [ :k :v | s := s copyReplaceAll: '<', k, '>' with: v ].
	^ s.
]

{ #category : #accessing }
MyAbstractExec >> vars [

	^ vars
]

{ #category : #accessing }
MyAbstractExec >> vars: anObject [

	vars := anObject
]
