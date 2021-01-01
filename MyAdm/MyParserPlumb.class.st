"
I am a plumb line for parser of multiple lines/strings.

Example:
```
                    .----------MyParserPlumb---------.
                    |                                |
                    v                        .-------+-------.
NAME OF USER       AGE  ADDRESS        SEX   | G  - #isChar  |
Poul John           12  NY  City         m   | 1  - #isChar  |
Ivan Soul            9  Paris   City     m   |' ' - #isSpace |
Molly Jonnecey      34  London City      f   | 3  - #isChar  |
                                             `-------+-------'
                                                     `---> #allVarious
```
MyParserPlumb - is a plumb-line, vertical scan-line, which iterates over chars
and generates events like #allSpaces, #allChars, #allVarious, #allOvers
(classifiers per line => 4 speficiers for 4 lines). The analyze is based
on FSM:
```
-----+---------+-------------------------------------------------------------------------
      \ states | #allOvers       #allSpaces            #allChars           #allVarious
events \       |
--------+------+-------------------------------------------------------------------------
#allSpaces           -               -                 end column          end column
                                                       state:=#allSpace    state:=#allSpaces

#allChars            -           end column                 -              state:=#allChars
                                 state:=#allChars

#allVarious          -           start column               -                    -
                                 state:=#allVarious

#allOvers            -           end column           end column           end column
                                 state:=#allOvers     state:=#allOvers     state:=#allOvers
```
"
Class {
	#name : #MyParserPlumb,
	#superclass : #Object,
	#instVars : [
		'lines',
		'bounds'
	],
	#category : #MyAdm
}

{ #category : #'private - utilities' }
MyParserPlumb class >> detectState: anAllPos [
	"Detect the FSM state based on all classifiers - the result of #classifyPos:atLine:"

	(#(#isOver) includesAll: anAllPos) ifTrue: [ ^ #allOvers ].
	(#(#isSpace) includesAll: anAllPos) ifTrue: [ ^ #allSpaces ].
	(#(#isChar) includesAll: anAllPos) ifTrue: [ ^ #allChars ].
	^ #allVarious
]

{ #category : #factory }
MyParserPlumb class >> withLines: aLines [
	^ self new lines: aLines; findBounds; yourself
]

{ #category : #'private - utilities' }
MyParserPlumb >> classifyPos: aPos atLine: aLineNumber [
	"Classifies an element of the line with atoms #isOver (no chars at this aPos),
	#isSpace (some space symbol at aPos), #isChar (non-blink character at this aPos)"

	| line |
	line := lines at: aLineNumber.
	aPos > line size ifTrue: [ ^ #isOver ] ifFalse: [
			(line at: aPos) isSpaceSeparator ifTrue: [ ^ #isSpace ] ifFalse: [ ^ #isChar ]
	]
]

{ #category : #enumerating }
MyParserPlumb >> collectColumns: aBlock [
	"Collects columns by iterating over rows then columns and calls aBlock with args rowNum, colNum, column"

	^ (1 to: lines size) collect: [ :rowNum |
		(1 to: bounds size) collect: [ :colNum |
			aBlock value: rowNum value: colNum value: (self extractColumn: colNum atRow: rowNum)
		]
	].
]

{ #category : #'private - utilities' }
MyParserPlumb >> doClassifiers: aBlock [
	"Iterates over all classifiers for each position of the vertical plumb-line"

	^ 1 to: self longestLineSize + 1 do: [ :pos | 
		  aBlock value: ((1 to: lines size) collect: [ :lineNumber | 
				   self classifyPos: pos atLine: lineNumber ]) ]
]

{ #category : #'finding/searching' }
MyParserPlumb >> extractColumn: aColumn atRow: aRow [
	"Extracts a column from the line of the aRow row"

	| line bound last |
	line := lines at: aRow. bound := bounds at: aColumn.
	last := bound last min: line size.
	^ (line copyFrom: bound first to: last) trim

]

{ #category : #'private - utilities' }
MyParserPlumb >> findBounds [
	"Finds all bounds - a list of Interval's - an one per a column"
	| state pos event void beg |
	state := #allSpaces. pos := 1. bounds := OrderedCollection new. beg := 1.
	void := self doClassifiers: [ :allClassifiers |
		event := self class detectState: allClassifiers.
		event = #allOvers ifTrue: [ state := #allOvers ].

		state = #allOvers ifTrue: [
			bounds add: (Interval from: beg to: pos - 1).
			^ bounds
		].
		state = #allSpaces ifTrue: [
			event = #allChars ifTrue: [ beg := pos. state := #allChars ].
			event = #allVarious ifTrue: [ beg := pos. state := #allVarious ].
		].
		state = #allChars ifTrue: [
			event = #allSpaces ifTrue: [ bounds add: (Interval from: beg to: pos - 1). state := #allSpaces ].
		].
		state = #allVarious ifTrue: [
			event = #allSpaces ifTrue: [ bounds add: (Interval from: beg to: pos - 1). state := #allSpaces ].
			event = #allChars ifTrue: [ state := #allChars ].
		].

		pos := pos + 1.
	].
	^ self
]

{ #category : #accessing }
MyParserPlumb >> lines [

	^ lines
]

{ #category : #'private - accessing' }
MyParserPlumb >> lines: anObject [

	lines := anObject
]

{ #category : #accessing }
MyParserPlumb >> longestLineSize [
	"Size of the longest line"
	
	^ (lines collect: #size) max
]
