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
The CPU achitecture - x86
The environment - HOME, SHELL, LANG, USER
The OS - Linux
```

by a splitting of lines (with either '.' or ';' or cr or lf delimiters) then splitting them on columns by
either ':' or '-' - which one is present in all lines.
"
Class {
	#name : #MyFlowParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'items',
		'columnsDelim'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyFlowParser class >> findColumnsDelim: aLines [
	
	"Finds a character which is used as a delimiter between columns (if it's possible to find it)"
	| linesDelims commonDelims |
	
	linesDelims := aLines collect: [ :line |
		line select: [ :ch | '-:' includes: ch ]
		].
	
	commonDelims := linesDelims reduce: [ :a :b | a intersection: b ].
	^ commonDelims ifEmpty: [ nil ] ifNotEmpty: [ commonDelims first ].
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

{ #category : #utilities }
MyFlowParser class >> trimColumn: aString [
	^ aString trimBoth: [ :ch | Character separators, Character specialCharacters includes: ch ]
]

{ #category : #accessing }
MyFlowParser >> columnsDelim [

	^ columnsDelim
]

{ #category : #accessing }
MyFlowParser >> columnsDelim: anObject [

	columnsDelim := anObject
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
	| lines |
	lines := self splitLines: aString.
	columnsDelim ifNil: [ columnsDelim := self class findColumnsDelim: lines ].
	items := columnsDelim
		ifNil: [ lines collect: [ :line | { line } ] ]
		ifNotNil: [
			lines collect: [ :line |
				line splitOn: columnsDelim
				]
			].
	items := items collect: [ :row |
		row collect: [ :col | self class trimColumn: col ]
		].

]

{ #category : #utilities }
MyFlowParser >> splitLines: aString [
	"Splits aString into lines and drops margins if they exist"
	^ self dataLines: (self class splitLines: aString)
]
