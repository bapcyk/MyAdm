Class {
	#name : #MyJSONColumnsParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'items',
		'header',
		'zoomIn'
	],
	#category : #MyAdm
}

{ #category : #utilities }
MyJSONColumnsParser class >> findColumnsDelim: aLines [
	
	"Finds a character which is used as a delimiter between columns (if it's possible to find it)"
	| linesDelims commonDelims |
	
	linesDelims := aLines collect: [ :line |
		line select: [ :ch | '-:=' includes: ch ]
		].
	
	commonDelims := linesDelims reduce: [ :a :b | a intersection: b ].
	^ commonDelims ifEmpty: [ nil ] ifNotEmpty: [ commonDelims first ].
]

{ #category : #utilities }
MyJSONColumnsParser class >> splitLines: aString [
	"Splits a string to lines by EOL delimiters"

	^ (aString splitOn: [ :ch | ch = Character cr or: ch = Character lf ])

]

{ #category : #utilities }
MyJSONColumnsParser class >> trimColumn: aString [
	^ aString trimBoth: [ :ch | Character separators includes: ch ]
]

{ #category : #accessing }
MyJSONColumnsParser >> data [
	^ items

]

{ #category : #accessing }
MyJSONColumnsParser >> header [

	^ header
]

{ #category : #accessing }
MyJSONColumnsParser >> header: anObject [

	header := anObject
]

{ #category : #initialization }
MyJSONColumnsParser >> initialize [
	header := #().


]

{ #category : #testing }
MyJSONColumnsParser >> isEmpty [
	^ items isEmpty
]

{ #category : #parsing }
MyJSONColumnsParser >> parse: aString [
	| json |
	json := STONJSON fromString: aString.
	zoomIn ifNotNil: [ json := json at: zoomIn ].
	items := OrderedCollection new.
	json keysAndValuesDo: [ :k :v |
		items add: { k asString. v asString }
	].
]

{ #category : #utilities }
MyJSONColumnsParser >> splitLines: aString [
	"Splits aString into lines and drops margins if they exist"
	| lines |
	lines := self dataLines: (self class splitLines: aString).
	^ lines reject: [ :line | self isCommentedLine: line ].
]

{ #category : #accessing }
MyJSONColumnsParser >> zoomIn: anObject [

	zoomIn := anObject
]
