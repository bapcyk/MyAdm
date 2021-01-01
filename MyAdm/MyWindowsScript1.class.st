"
Local Windows scripting.
"
Class {
	#name : #MyWindowsScript1,
	#superclass : #MyAbstractScript,
	#category : #MyAdm
}

{ #category : #running }
MyWindowsScript1 >> run [
	|exec cmd|
	"exec := MySockExec new initializeWithAddr: '127.0.0.1' port: 9999."
	exec := MyPoshExec new.
	"exec vars at: 'REMOTE-BIN' put: '/home/pavel/bin'."
	cmd := MyWinServicesCmd new initializeWithExec: exec.
	cmd runUI: #().

]
