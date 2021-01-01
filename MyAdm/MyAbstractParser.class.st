"
I am an abstract columns parser
"
Class {
	#name : #MyAbstractParser,
	#superclass : #Object,
	#category : #MyAdm
}

{ #category : #parsing }
MyAbstractParser class >> parse: aString withHeader: aBoolean [
	self subclassResponsibility
]

{ #category : #accessing }
MyAbstractParser >> data [
	"Getter of rows (list of columns) containing data only, not header"

	self subclassResponsibility

]

{ #category : #accessing }
MyAbstractParser >> header [
	"Getter of the header columns list"
	self subclassResponsibility

]

{ #category : #testing }
MyAbstractParser >> isEmpty [
	"A flag: is any data rows"
	self subclassResponsibility

]

{ #category : #testing }
MyAbstractParser >> isHeaderless [
	"Returns a flag: are headers missing"
	self subclassResponsibility

]
