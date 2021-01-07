"
I am an applier (editor) of the secret via a command `<REMOTE-BIN>/kubectl apply -f -`
"
Class {
	#name : #MyKubeApplySecretCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeApplySecretCmd >> help [
	^ 'Apply Edited File'
]

{ #category : #initialization }
MyKubeApplySecretCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Apply Secret'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubeApplySecretCmd >> run: anArgs [
	| pod secretItem contents encodedContents json theCmdArgs |
	contents := anArgs first.
	secretItem := anArgs second.
	pod := anArgs third.
	json := STONJSON fromString: anArgs fourth.

	encodedContents := contents asString asByteArray base64Encoded.
	(json at: 'data') at: secretItem put: encodedContents.
	contents := (STONJSON toString: json) asString asByteArray.

	theCmdArgs := MyCmdArgs
		fromArgs: { '<REMOTE-BIN>/kubectl'. 'apply'. '-f'. '-'. }
		stdin: contents.

	^ exec exec: theCmdArgs.

]

{ #category : #running }
MyKubeApplySecretCmd >> runUI: anArgs [
	^ self run: anArgs
]

{ #category : #utilities }
MyKubeApplySecretCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
