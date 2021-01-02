"
I am an abstract columns parser
"
Class {
	#name : #MyAbstractParser,
	#superclass : #Object,
	#instVars : [
		'margins'
	],
	#category : #MyAdm
}

{ #category : #parsing }
MyAbstractParser class >> blankCharacters [

	"Returns blank characters"

	^ { 
		  Character tab.
		  Character cr.
		  Character lf.
		  Character space }
]

{ #category : #utilities }
MyAbstractParser class >> isBlankString: aString [

	"Checks that aString consists of blank characters only"

	^ self blankCharacters includesAll: aString
]

{ #category : #accessing }
MyAbstractParser >> data [
	"Getter of rows (list of columns) containing data only, not header"

	self subclassResponsibility

]

{ #category : #accessing }
MyAbstractParser >> dataLines: aLines [
	"Returns data lines only, without margins (if they exist)"
	| interval |
	margins ifNil: [ ^ aLines ].
	interval := margins dataLinesInterval: aLines.
	^ interval ifNil: aLines ifNotNil: [ aLines copyFrom: interval first to: interval last ].
]

{ #category : #testing }
MyAbstractParser >> isEmpty [
	"A flag: is any data rows"
	self subclassResponsibility

]

{ #category : #accessing }
MyAbstractParser >> margins: anObject [

	margins := anObject
]

{ #category : #parsing }
MyAbstractParser >> parse: aString [
	self subclassResponsibility
]
