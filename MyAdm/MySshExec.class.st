"
I am a primitive SSH commands executor.
"
Class {
	#name : #MySshExec,
	#superclass : #MyAbstractExec,
	#instVars : [
		'addr',
		'user',
		'bin'
	],
	#category : #MyAdm
}

{ #category : #defaults }
MySshExec class >> defaultTimeout [
	"Default timeout in seconds"
	^ 10
]

{ #category : #abstract }
MySshExec >> execString: aString [

	^ LibC resultOfCommand: ('{1} -l {2} {3} {4}' format: {bin. user. addr. aString})
]

{ #category : #initialization }
MySshExec >> initializeWithAddr: anAddr user: anUser [
	self initializeWithAddr: anAddr user: anUser bin: 'ssh'.
]

{ #category : #initialization }
MySshExec >> initializeWithAddr: anAddr user: anUser bin: aBinPath [
	addr := anAddr.
	user := anUser.
	bin := aBinPath.
]
