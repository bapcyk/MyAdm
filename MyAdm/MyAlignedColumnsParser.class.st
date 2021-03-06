"
I am a parser of alignment text columns. I can parse text like:

```
NAME OF USER       AGE  ADDRESS        SEX
Poul John           12  NY  City         m
Ivan Soul            9  Paris   City     m
Molly Jonnecey      34  London City      f
```
or even:
```
NAME OF USER   |   AGE | ADDRESS      | SEX
---------------+-------+--------------+----
               |       |              |
Poul John      |    12 | NY  City     |   m
Ivan Soul      |     9 | Paris   City |   m
Molly Jonnecey |    34 | London City  |   f
```
by a determining of the columns vertical bounds.

"
Class {
	#name : #MyAlignedColumnsParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'items',
		'headerless',
		'customHeader'
	],
	#category : #MyAdm
}

{ #category : #constants }
MyAlignedColumnsParser class >> artifactChars [
	"Characters that can be treated as artifacts, so can be removed, they dont form columns values"

	^ '|'
]

{ #category : #constants }
MyAlignedColumnsParser class >> ignoredChars [
	"Ignored characters"

	^ self artifactChars, ' -+=~#%*!:.:^', String tab

]

{ #category : #testing }
MyAlignedColumnsParser class >> isBlankLine: aLine [
	"Checks if aLine is a blank (non-valuable) line - empty, no data, just markup, etc"

	^ self ignoredChars includesAll: aLine
]

{ #category : #utilities }
MyAlignedColumnsParser class >> replaceArtifacts: aLine [
	"Replaces artifacts (artifactChars) in the line by space"

	^ aLine collect: [ :ch | 
		(self artifactChars includes: ch)
			ifTrue: Character space
			ifFalse: ch ]
]

{ #category : #utilities }
MyAlignedColumnsParser class >> splitLines: aString [
	"Splits a string to lines by EOL delimiters"

	^ (aString splitOn: [ :ch | ch = Character cr or: ch = Character lf ])
		collect: [ :line | self replaceArtifacts: line ]
		thenReject: [ :line | line isEmpty or: (self isBlankLine: line) ]
]

{ #category : #accessing }
MyAlignedColumnsParser >> allRows [
	^ items
]

{ #category : #accessing }
MyAlignedColumnsParser >> columnsNumber [
	"Returns a number of the columns"

	items isEmpty ifTrue: [ ^ 0 ] ifFalse: [ ^ items first size ]
]

{ #category : #accessing }
MyAlignedColumnsParser >> data [
	"Returns data rows only (without header row)"
	| rng |

	rng := self dataRowsInterval.
	^ rng ifNotNil: [ items copyFrom: rng first to: rng last ] ifNil: [ nil ].

]

{ #category : #accessing }
MyAlignedColumnsParser >> dataRowsInterval [
	"Range of the data rows (without the header). If no data, then returns nil"

	^ self isEmpty
		ifTrue: [ nil ]
		ifFalse: [ headerless
			ifTrue: [ Interval from: 1 to: items size ]
			ifFalse: [ Interval from: 2 to: items size ] ]
]

{ #category : #accessing }
MyAlignedColumnsParser >> dataRowsNumber [

	items isEmpty ifTrue: [ ^ 0 ] ifFalse: [
		headerless ifTrue: [ ^ items size ] ifFalse: [ ^ items size - 1]
		]
]

{ #category : #accessing }
MyAlignedColumnsParser >> header [
	
	"Returns columns of the header"
	
	customHeader ifNotNil: [ ^ customHeader ].
	
	items isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [
			headerless
				ifFalse: [ ^ items first ]
				ifTrue: [
					^ (1 to: self columnsNumber) collect: [ :i | 'COL', i asString ]
				]
		]

]

{ #category : #accessing }
MyAlignedColumnsParser >> header: aHeader [

	"Sets a new header aHeader which is a list of columns (or nil - to disable headers)
	or replaces existing one"

	aHeader
		ifNil: [
			headerless := true.
			customHeader := nil ]
		ifNotNil: [ 
			headerless := true.
			customHeader := aHeader ]
]

{ #category : #initialization }
MyAlignedColumnsParser >> initialize [
	headerless := false.
	items := #().
]

{ #category : #testing }
MyAlignedColumnsParser >> isEmpty [
	"Tests - is not data rows"

	^ 0 = self dataRowsNumber
]

{ #category : #accessing }
MyAlignedColumnsParser >> items [
	^ items
]

{ #category : #accessing }
MyAlignedColumnsParser >> items: anItems [
	items := anItems
]

{ #category : #parsing }
MyAlignedColumnsParser >> parse: aString [
   | plumb |
	plumb := MyParserPlumb withLines: (self splitLines: aString).
	items := plumb collectColumns: [ :rowNum :colNum :col | col ].


]

{ #category : #utilities }
MyAlignedColumnsParser >> splitLines: aString [
	"Splits aString into lines and drops margins if they exist"
	^ self dataLines: (self class splitLines: aString)
]
