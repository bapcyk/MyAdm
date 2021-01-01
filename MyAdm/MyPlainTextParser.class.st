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

{ #category : #parsing }
MyPlainTextParser class >> parse: aString withHeader: aBoolean [
	^ self new text: aString
]

{ #category : #accessing }
MyPlainTextParser >> data [
	"Getter of rows (list of columns) containing data only, not header"

	^ text

]

{ #category : #accessing }
MyPlainTextParser >> header [
	"Getter of the header columns list"
	^ #()

]

{ #category : #testing }
MyPlainTextParser >> isEmpty [
	"A flag: is any data rows"
	^ text isEmpty

]

{ #category : #testing }
MyPlainTextParser >> isHeaderless [
	"Returns a flag: are headers missing"
	^ true

]

{ #category : #accessing }
MyPlainTextParser >> text: anObject [

	text := anObject
]
