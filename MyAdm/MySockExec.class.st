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

{ #category : #abstract }
MySockExec >> execString: aString [

	| sock resAddr res |
	sock := Socket newTCP.
	resAddr := NetNameResolver addressForName: addr.
	^ [ 
	  sock
		  connectTo: resAddr port: port;
		  waitForConnectionFor: self class defaultTimeout;
		  sendData: aString.
	  res := sock receiveDataTimeout: self class defaultTimeout.
	  res ] ensure: [ sock closeAndDestroy ]
]

{ #category : #initialization }
MySockExec >> initializeWithAddr: anAddr port: aPort [
	addr := anAddr.
	port := aPort.
]
