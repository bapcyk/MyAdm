"
I am a commands executor through socket - the socket is connecting, then the command is sending, then the socket is disconnecting.
"
Class {
	#name : #MySockExec,
	#superclass : #MyAbstractExec,
	#instVars : [
		'addr',
		'port'
	],
	#category : #MyAdm
}

{ #category : #defaults }
MySockExec class >> defaultTimeout [
	"Default timeout in seconds"
	^ 10
]

{ #category : #initialization }
MySockExec >> initializeWithAddr: anAddr port: aPort [
	addr := anAddr.
	port := aPort.
]

{ #category : #abstract }
MySockExec >> operate: aCmdArgs [

	| sock resAddr res |
	sock := Socket newTCP.
	resAddr := NetNameResolver addressForName: addr.
	^ [ 
	  sock
		  connectTo: resAddr port: port;
		  waitForConnectionFor: self class defaultTimeout;
		  sendData: aCmdArgs asString.
	  res := sock receiveDataTimeout: self class defaultTimeout.
	  res ] ensure: [ sock closeAndDestroy ]
]
