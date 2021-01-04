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

{ #category : #converting }
MyAbstractExec >> decode: aString [
	^ encoding ifNil: [ aString ] ifNotNil: [ aString convertFromEncoding: encoding ].
]

{ #category : #utilities }
MyAbstractExec >> doExecString: aString [
	"Calls successor's execString implementation"
	^ self decode: (self execString: (self decode: aString)).
	
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
MyAbstractExec >> exec: aCmd [

	"Executes a list of arguments or a string command.
	XXX THIS MESSAGE MUST BE USED TO EXECUTE SOMETHING, NOT execArgs neither execString!!!"

	^ aCmd isString
		  ifTrue: [ self doExecString: (self substVars: aCmd) ]
		  ifFalse: [ 
		  self execArgs: (aCmd collect: [ :c | self substVars: c ]) ]
]

{ #category : #utilities }
MyAbstractExec >> execArgs: anArgs [
	"Executes a command represented as a list"
	^ self doExecString: (self argsAsString: anArgs)
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
	encoding := 'utf-8'.

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
