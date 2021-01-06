"
I am a abstract script
"
Class {
	#name : #MyAbstractScript,
	#superclass : #Object,
	#instVars : [
		'cfg'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyAbstractScript >> at: aKey [
	^ cfg at: aKey
]

{ #category : #accessing }
MyAbstractScript >> at: aKey1 at: aKey2 [
	^ (cfg at: aKey1) at: aKey2
]

{ #category : #initialization }
MyAbstractScript >> initialize [
	self initializeWithCfg: 'MyAdm.cfg'
]

{ #category : #initialization }
MyAbstractScript >> initializeWithCfg: aCfgPath [
	| key |
	key := self class name.
	cfg := aCfgPath asFileReference readStreamDo: [ :stream | STONJSON fromStream: stream ].
]

{ #category : #accessing }
MyAbstractScript >> myAt: aKey [
	"Answers config parameters with aKey"
	^ self at: (self class name) at: aKey
]

{ #category : #initialization }
MyAbstractScript >> run [
	self subclassResponsibility
]
