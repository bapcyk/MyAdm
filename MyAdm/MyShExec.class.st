"
I am a simple shell executor.
"
Class {
	#name : #MyShExec,
	#superclass : #MyAbstractExec,
	#category : #MyAdm
}

{ #category : #defaults }
MyShExec class >> defaultTimeout [
	"Default timeout in seconds"
	^ 10
]

{ #category : #abstract }
MyShExec >> operate: aCmdArgs [

	^ LibC resultOfCommand: aCmdArgs asString.

]
