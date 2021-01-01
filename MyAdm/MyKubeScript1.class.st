"
Kubernetes visual scripts.
"
Class {
	#name : #MyKubeScript1,
	#superclass : #MyAbstractScript,
	#category : #MyAdm
}

{ #category : #initialization }
MyKubeScript1 >> run [

	| exec cmd |
	"exec := MySockExec new initializeWithAddr: '127.0.0.1' port: 9999. "
	exec := MySshExec new
		        initializeWithAddr: (self myAt: 'sshAddr')
		        user: (self myAt: 'sshUser')
		        bin: (self myAt: 'sshBin').
	exec vars at: 'REMOTE-BIN' put: (self myAt: 'remoteBin').
	cmd := MyKubePodsCmd new initializeWithExec: exec.
	cmd runUI: #(  )
]
