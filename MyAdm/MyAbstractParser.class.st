"
I am an abstract columns parser
"
Class {
	#name : #MyAbstractParser,
	#superclass : #Object,
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

{ #category : #testing }
MyAbstractParser >> isEmpty [
	"A flag: is any data rows"
	self subclassResponsibility

]

{ #category : #parsing }
MyAbstractParser >> parse: aString [
	self subclassResponsibility
]
