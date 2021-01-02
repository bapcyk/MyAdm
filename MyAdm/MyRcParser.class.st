"
I am a parser of Linux RC files
"
Class {
	#name : #MyRcParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'items',
		'columnsDelim',
		'header',
		'commentsLeaders'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyRcParser class >> findColumnsDelim: aLines [
	
	"Finds a character which is used as a delimiter between columns (if it's possible to find it)"
	| linesDelims commonDelims |
	
	linesDelims := aLines collect: [ :line |
		line select: [ :ch | '-:=' includes: ch ]
		].
	
	commonDelims := linesDelims reduce: [ :a :b | a intersection: b ].
	^ commonDelims ifEmpty: [ nil ] ifNotEmpty: [ commonDelims first ].
]

{ #category : #utilities }
MyRcParser class >> splitLines: aString [
	"Splits a string to lines by EOL delimiters"

	^ (aString splitOn: [ :ch | ch = Character cr or: ch = Character lf ])

]

{ #category : #utilities }
MyRcParser class >> trimColumn: aString [
	^ aString trimBoth: [ :ch | Character separators, Character specialCharacters includes: ch ]
]

{ #category : #accessing }
MyRcParser >> columnsDelim [

	^ columnsDelim
]

{ #category : #accessing }
MyRcParser >> columnsDelim: anObject [

	columnsDelim := anObject
]

{ #category : #accessing }
MyRcParser >> commentsLeaders [

	^ commentsLeaders
]

{ #category : #accessing }
MyRcParser >> commentsLeaders: anObject [

	commentsLeaders := anObject
]

{ #category : #accessing }
MyRcParser >> data [
	^ items

]

{ #category : #accessing }
MyRcParser >> header [

	^ header
]

{ #category : #accessing }
MyRcParser >> header: anObject [

	header := anObject
]

{ #category : #initialization }
MyRcParser >> initialize [
	header := #().
	commentsLeaders := #('#').

]

{ #category : #testing }
MyRcParser >> isCommentedLine: aLine [
	"Checks if aLine starts with one of the commentsLeaders"
	^ aLine trim beginsWithAnyOf: commentsLeaders

]

{ #category : #testing }
MyRcParser >> isEmpty [
	^ items isEmpty
]

{ #category : #parsing }
MyRcParser >> parse: aString [
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
MyRcParser >> splitLines: aString [
	"Splits aString into lines and drops margins if they exist"
	| lines |
	lines := self dataLines: (self class splitLines: aString).
	^ lines reject: [ :line | self isCommentedLine: line ].
]
