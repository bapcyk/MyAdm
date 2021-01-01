"
I am a TCP socket based commands executor. Example:
```
sock := MySockCmd newConnection.
resp := WideString fromString: (sock sendAndRecv: 'something').
```
"
Class {
	#name : #MySockSessExec,
	#superclass : #MyAbstractExec,
	#instVars : [
		'sock',
		'addr'
	],
	#category : #MyAdm
}

{ #category : #defaults }
MySockSessExec class >> defaultAddr [
	"Default address"
			
	^ 'localhost'
]

{ #category : #defaults }
MySockSessExec class >> defaultPort [
	"Default port number"

	^ 9999
]

{ #category : #defaults }
MySockSessExec class >> defaultTimeout [
	"Default timeout value in seconds"

	^ 10
]

{ #category : #'instance creation' }
MySockSessExec class >> newConnection [
	"Factory of the new connection with default parameters"
	| me |
	me := self new.
	me initializeWithSock: (Socket newTCP) addr: (NetNameResolver addressForName:self defaultAddr).
	me sock connectTo: me addr port: self defaultPort;
	waitForConnectionFor: self defaultTimeout.
	^ me.
]

{ #category : #accessing }
MySockSessExec >> addr [
	"addr getter"

	^ addr
]

{ #category : #'connection open/close' }
MySockSessExec >> disconnect [
	"Disconnect from the socket"

	self sock closeAndDestroy
]

{ #category : #abstract }
MySockSessExec >> execString: aString [
	"Executes command, returns ByteString"
	^ self sendAndRecv: aString
]

{ #category : #initialization }
MySockSessExec >> initializeWithSock: aSocket addr: anAddress [
	"Constructor with a socket and an address"
	sock ifNotNil: [ self disconnect ].
	sock := aSocket.
	addr := anAddress.
]

{ #category : #accessing }
MySockSessExec >> next [
	"Gets next data from the socket"

	^ self sock receiveDataTimeout: self class defaultTimeout.
]

{ #category : #accessing }
MySockSessExec >> nextPutAll: aData [
	"Sends aData through the socket"

	^ self sock sendData: aData.
]

{ #category : #accessing }
MySockSessExec >> sendAndRecv: aData [
	"Sends and receives through the socket"

	^ self nextPutAll: aData; next.
]

{ #category : #accessing }
MySockSessExec >> sock [
	"sock getter"

	^ sock

]
