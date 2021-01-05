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

{ #category : #initialization }
MyPoshExec >> initialize [
	super initialize.
	bin := 'powershell.exe'.
]

{ #category : #initialization }
MyPoshExec >> initializeWithBin: aBinPath [
	bin := aBinPath.
]

{ #category : #abstract }
MyPoshExec >> operate: aCmdArgs [

	^ LibC resultOfCommand: ('{1} -Command {2}' format: {bin. aCmdArgs asString})
]
