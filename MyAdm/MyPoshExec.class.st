"
I am a simple PowerShell executor.
"
Class {
	#name : #MyPoshExec,
	#superclass : #MyAbstractExec,
	#instVars : [
		'bin'
	],
	#category : #MyAdm
}

{ #category : #defaults }
MyPoshExec class >> defaultTimeout [
	"Default timeout in seconds"
	^ 10
]

{ #category : #abstract }
MyPoshExec >> execString: aString [

	^ LibC resultOfCommand: ('{1} -Command {2}' format: {bin. aString})
]

{ #category : #initialization }
MyPoshExec >> initialize [
	super initialize.
	bin := 'powershell.exe'.
]

{ #category : #initialization }
MyPoshExec >> initializeWithBin: aBinPath [
	bin := aBinPath.
]
