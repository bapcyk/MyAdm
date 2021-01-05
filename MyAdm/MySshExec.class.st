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

{ #category : #initialization }
MySshExec >> initializeWithAddr: anAddr user: anUser bin: aBinPath [
	addr := anAddr.
	user := anUser.
	bin := aBinPath.
]

{ #category : #abstract }
MySshExec >> operate: aCmdArgs [
	^ aCmdArgs stdin
		ifNil: [
			LibC resultOfCommand: ('{1} -l {2} {3} {4}' format: {bin. user. addr. aCmdArgs asString})
		]
		"ifNotNil: [
			pipe := LibC pipe: ('{1} -l {2} {3} {4}' format: {bin. user. addr. aCmdArgs asString}) mode: 'w'.
		]"
]

{ #category : #utilities }
MySshExec >> runCmd: aCmdLine stdin: aStdinData [

	| pipe |
	pipe := MyLibC uniqueInstance.
	pipe := pipe pipe: aCmdLine mode: 'wb'.
	[ pipe fwrite: aStdinData size: aStdinData size pipe: pipe ] ensure: [ 
		pipe fflush: pipe.
		pipe pipeClose: pipe ]
]

{ #category : #classification }
MySshExec >> supports: aFeature [
	^ #(#stdin) includes: aFeature
]
