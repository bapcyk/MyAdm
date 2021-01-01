"
I am an abstract columns parser
"
Class {
	#name : #MyAbstractParser,
	#superclass : #Object,
	#category : #MyAdm
}

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
