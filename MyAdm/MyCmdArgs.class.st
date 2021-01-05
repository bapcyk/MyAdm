"
I am a container of command line arguments. I have `args` - the list of all arguments, when it is converted to the command
line then I have a `line` attribute which is not `nil` in that case.
"
Class {
	#name : #MyCmdArgs,
	#superclass : #Object,
	#instVars : [
		'args',
		'arg',
		'line',
		'stdin'
	],
	#category : #MyAdm
}

{ #category : #'instance creation' }
MyCmdArgs class >> fromArgs: anArgs [
	^ self new args: anArgs
]

{ #category : #'instance creation' }
MyCmdArgs class >> fromArgs: anArgs stdin: anStdin [
	^ self new args: anArgs; stdin: anStdin
]

{ #category : #'instance creation' }
MyCmdArgs class >> fromLine: aString [
	"From ready-to-run command line. The executor will not quote it"
	^ self new arg: aString.
]

{ #category : #private }
MyCmdArgs >> arg [
	"Returns arg which can be nil if it was created from arguments list"
	^ arg
]

{ #category : #private }
MyCmdArgs >> arg: anObject [
	arg := anObject.
	line := nil.
	args := nil.
]

{ #category : #private }
MyCmdArgs >> args [

	^ args
]

{ #category : #private }
MyCmdArgs >> args: anObject [
	args := anObject.
	line := nil.
	arg := nil.
]

{ #category : #converting }
MyCmdArgs >> asString [
	^ line
]

{ #category : #testing }
MyCmdArgs >> isString [
	"Returns true if it is one arg object otherwise (a list of args) - returns false"
	^ arg isNotNil
]

{ #category : #splitjoin }
MyCmdArgs >> joinUsing: aDelim [
	"Joins arguments using the delimiter aDelim, changes line var because it's ready to be run"
	line := args joinUsing: aDelim.
]

{ #category : #private }
MyCmdArgs >> line: anObject [

	line := anObject
]

{ #category : #processing }
MyCmdArgs >> processArg: aBlock [
	"Changes arg and line because it's ready to be run"
	arg := aBlock value: arg.
	line := arg.
]

{ #category : #processing }
MyCmdArgs >> processArgs: aBlock [
	"Collects on args var. Changes args var with the result and returns itself"
	args := args collect: aBlock.

]

{ #category : #processing }
MyCmdArgs >> processLine: aBlock [
	"Changes the line"
	line := aBlock value: line.

]

{ #category : #accessing }
MyCmdArgs >> size [
	^ args size
]

{ #category : #accessing }
MyCmdArgs >> stdin [

	^ stdin
]

{ #category : #private }
MyCmdArgs >> stdin: anObject [

	stdin := anObject
]
