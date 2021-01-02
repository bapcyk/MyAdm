"
I am a margins (header, footer) cutter of lines
"
Class {
	#name : #MyParseMargins,
	#superclass : #Object,
	#instVars : [
		'block',
		'topSize',
		'bottomSize'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyParseMargins >> block: aBoolean [
	"Sets the flag - margins are as blocks (not lines but lines delimited with empty lines)"
	
	block := aBoolean
]

{ #category : #accessing }
MyParseMargins >> bottomSize: anObject [

	bottomSize := anObject
]

{ #category : #accessing }
MyParseMargins >> data: aLines [
	"Returns data lines without margins"

]

{ #category : #utilities }
MyParseMargins >> findBlockMargin: aMargin lines: aLines [
	"Find the margin (aMargin is #top, #bottom) for lines list aLines"
	| iter foundCheck lastLineCheck marginSize state isBlankLine isLastLine line marginLines |
	marginSize := 0. state := #start.

	aMargin = #top
		ifTrue: [ iter := 1 to: aLines size.
			       marginLines := [ :marginBound :onLastLine |
						  onLastLine ifTrue: [ marginBound ] ifFalse: [ marginBound - 1 ] ].
					 foundCheck := [ marginSize = topSize ].
					 lastLineCheck := [ :iLine | iLine = aLines size ] ]
		ifFalse: [ iter := aLines size to: 1 by: -1.
					  marginLines := [ :marginBound :onLastLine |
						  onLastLine ifTrue: [ aLines size - marginBound + 1 ] ifFalse: [ aLines size - marginBound ] ].
					  foundCheck := [ marginSize = bottomSize ].
					  lastLineCheck := [ :iLine | iLine = 1 ] ].

	iter do: [ :iLine |
		"events"
		line := aLines at: iLine.
		isBlankLine := line isEmpty or: (MyAbstractParser isBlankString: line).
		isLastLine := lastLineCheck value: iLine.
		Transcript show: iLine; tab; show: line; tab; show: isBlankLine; tab; show: isLastLine; cr.
		"states processing"
		state = #start ifTrue: [ state := isBlankLine ifTrue: [ #empty ] ifFalse: [ #filled ] ].
		state = #empty ifTrue: [ isBlankLine ifFalse: [ state := #filled ] ].
		state = #filled ifTrue: [ 
			(isBlankLine or: isLastLine) ifTrue: [ 
				marginSize := marginSize + 1.
				foundCheck value ifTrue: [ ^ marginLines value: iLine value: isLastLine ].
				state := #empty ] ] ].
	^ 0
]

{ #category : #initialization }
MyParseMargins >> initialize [
	block := false.
	topSize := 0.
	bottomSize := 0.
]

{ #category : #accessing }
MyParseMargins >> topSize: anObject [

	topSize := anObject
]
