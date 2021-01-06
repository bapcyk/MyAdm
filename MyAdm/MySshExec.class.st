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
		ifNotNil: [
			| cmdLine |
			cmdLine := '{1} -l {2} {3} {4}' format: { bin. user. addr. aCmdArgs asString. }.
			self runCmd: cmdLine stdin: aCmdArgs stdin.
			''
		]
]

{ #category : #utilities }
MySshExec >> runCmd: aCmdLine stdin: aStdinData [

	| pipe libC |
	libC := MyLibC uniqueInstance.
	pipe := libC pipe: aCmdLine mode: 'wb'.
	[ libC fwrite: aStdinData size: 1 count: aStdinData size pipe: pipe ] ensure: [ 
		libC fflush: pipe.
		libC pipeClose: pipe ]
]

{ #category : #classification }
MySshExec >> supports: aFeature [
	^ #(#stdin) includes: aFeature
]
