"
I am a command applying changes to the opened file. The algorithm uses the command:
`ssh.exe -l XX XX.XX.XX.XX kubectl exec -i <POD> sh -- -c ""'cat > \\""<PATH>\\""'""`

So, it compress first the file into .gz file then it send it to the stdin of this command (internally).
It can be reproduced in the terminal as `zcat xxx.gz|<THAT-COMMAND>`.
"
Class {
	#name : #MyKubeApplyFileCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeApplyFileCmd >> help [
	^ 'Apply Edited File'
]

{ #category : #initialization }
MyKubeApplyFileCmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Apply File'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #utilities }
MyKubeApplyFileCmd >> run: anArgs [
	| pod path contents compressedContents theCmdArgs |
	pod := anArgs first.
	path := anArgs second.
	contents := anArgs third.
	compressedContents := MyGzip compress: contents asString asByteArray.

	theCmdArgs := MyCmdArgs
		fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'sh'. '--'. '-c'. '"''zcat > \"', path, '\"''"'. }
		stdin: compressedContents.

	^ exec exec: theCmdArgs.

]

{ #category : #running }
MyKubeApplyFileCmd >> runUI: anArgs [
	^ self run: anArgs
]

{ #category : #utilities }
MyKubeApplyFileCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
