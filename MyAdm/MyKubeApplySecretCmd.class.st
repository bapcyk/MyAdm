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
	| pod secretItem contents json compressedContents theCmdArgs |
	contents := anArgs first.
	secretItem := anArgs second.	
	pod := anArgs third.
	json := anArgs fourth.

	compressedContents := MyGzip compress: contents asString asByteArray.

	theCmdArgs := MyCmdArgs
		fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'sh'. '--'. '-c'. '"''zcat > \"', '<XXX>', '\"''"'. }
		stdin: compressedContents.

	^ exec exec: theCmdArgs.

]

{ #category : #utilities }
MyKubeApplySecretCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
