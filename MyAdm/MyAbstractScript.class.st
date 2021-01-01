"
I am a abstract script
"
Class {
	#name : #MyAbstractScript,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #MyAdm
}

{ #category : #accessing }
MyAbstractScript >> at: aKey [
	^ data at: aKey
]

{ #category : #accessing }
MyAbstractScript >> at: aKey1 at: aKey2 [
	^ (data at: aKey1) at: aKey2
]

{ #category : #accessing }
MyAbstractScript >> data [

	^ data
]

{ #category : #accessing }
MyAbstractScript >> data: anObject [

	data := anObject
]

{ #category : #initialization }
MyAbstractScript >> initialize [
	self initializeWithCfg: 'MyAdm.cfg'
]

{ #category : #initialization }
MyAbstractScript >> initializeWithCfg: aCfgPath [
	| key |
	key := self class name.
	data := aCfgPath asFileReference readStreamDo: [ :stream | STONJSON fromStream: stream ].
]

{ #category : #accessing }
MyAbstractScript >> myAt: aKey [
	^ self at: (self class name) at: aKey
]

{ #category : #initialization }
MyAbstractScript >> run [
	self subclassResponsibility
]
