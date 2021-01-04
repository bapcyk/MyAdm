Class {
	#name : #MyKubeGetFileCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #utilities }
MyKubeGetFileCmd >> askSaveAs [
	| dialog |
	dialog := FileDialogWindow new
		title: 'Save As...';
		answerSaveFile.
	^ dialog openModal answer
]

{ #category : #accessing }
MyKubeGetFileCmd >> help [
	^ 'Get File content locally'
]

{ #category : #initialization }
MyKubeGetFileCmd >> initializeWithExec: anExec [
	"Initializes the command with the executor instance anExec"
	| binExec |
	binExec := anExec shallowCopy.
	binExec encoding: nil.

	self
		initializeWithName: 'Get File'
		subCmds: #( )
		exec: binExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubeGetFileCmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubeGetFileCmd >> run: anArgs [
	| pod readPath writePath res |
	pod := anArgs first.
	readPath := anArgs second.
	writePath := anArgs third.
	res := exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-it'. pod. 'gzip'. '--'. '-c'. readPath. }.
	writePath writeStreamDo: [ :stream | stream << res ].
	

]

{ #category : #running }
MyKubeGetFileCmd >> runUI: anArgs [
	| writePath |
	writePath := self askSaveAs.
	^ self run: (anArgs copyWith: writePath).

]

{ #category : #utilities }
MyKubeGetFileCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
