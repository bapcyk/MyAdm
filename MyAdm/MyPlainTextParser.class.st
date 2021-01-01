"
I am a dummy (plain text) parser, which returns the text as-is
"
Class {
	#name : #MyPlainTextParser,
	#superclass : #MyAbstractParser,
	#instVars : [
		'text'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyPlainTextParser >> data [
	"Getter of rows (list of columns) containing data only, not header"

	^ text

]

{ #category : #testing }
MyPlainTextParser >> isEmpty [
	"A flag: is any data rows"
	^ text isEmpty

]

{ #category : #parsing }
MyPlainTextParser >> parse: aString [
	self text: aString
]

{ #category : #accessing }
MyPlainTextParser >> text: anObject [

	text := anObject
]
