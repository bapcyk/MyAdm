"
Local Windows scripting.
"
Class {
	#name : #MyWindowsScript1,
	#superclass : #MyAbstractScript,
	#category : #MyAdm
}

{ #category : #initialization }
MyWindowsScript1 >> run [
	|exec cmd|
	"exec := MySockExec new initializeWithAddr: '127.0.0.1' port: 9999."
	exec := MyPoshExec new.
	cmd := MyWinServicesCmd new initializeWithExec: exec.
	cmd runUI: #().

]
