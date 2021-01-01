"
I am a parser of a text flow like:

```
The CPU achitecture - x86.
The environment - HOME, SHELL, LANG, USER,
PATH and TERM.
The OS - Linux
```

or

```
The CPU achitecture - x86.
The environment - HOME, SHELL, LANG, USER.
The OS - Linux
```
"
Class {
	#name : #MyFlowParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'items'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyFlowParser class >> findColumnsDelim: aLines [
	"Finds a character which is used as a delimiter between columns"
	^ nil
]

{ #category : #utilities }
MyFlowParser class >> splitLines: aString [

	"Splits aString into lines delimited by either '.' or ';' or crlf"

	| delim splitter |
	delim :=
		(aString includes: $.)
			ifTrue: [ $. ]
		   ifFalse: [ 
				(aString includes: $;)
					ifTrue: [ $; ]
					ifFalse: [ Character lf ] ].
	splitter := delim = Character lf
		ifTrue: [ [ :ch | ch = Character cr or: ch = Character lf] ]
		ifFalse: [ [ :ch | ch = delim ] ].
	^ aString splitOn: splitter.
]

{ #category : #accessing }
MyFlowParser >> data [
	^ items

]

{ #category : #testing }
MyFlowParser >> isEmpty [
	^ items isEmpty
]

{ #category : #parsing }
MyFlowParser >> parse: aString [
	^ nil
]
