"
I am a `kubectl exec -it <POD> gzip -- -c <PATH>` command
"
Class {
	#name : #MyKubeGetFileCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #utilities }
MyKubeGetFileCmd >> askSaveAs: aRecommendedName [
	"Asks for saving file name by an offer of the recommended file name"
	| dialog |
	dialog := FileDialogWindow new
		title: 'Save As...';
		fileNameText: aRecommendedName;
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
	writePath ifNil: [ ^ '' ].
	res := exec exec: (MyCmdArgs fromArgs: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'gzip'. '--'. '-c'. readPath. }).
	writePath binaryWriteStreamDo: [ :stream | stream nextPutAll: res ].
	

]

{ #category : #running }
MyKubeGetFileCmd >> runUI: anArgs [
	| writePath |
	writePath := self askSaveAs: anArgs second asFileReference basename, '.gz'.
	^ self run: (anArgs copyWith: writePath).

]

{ #category : #utilities }
MyKubeGetFileCmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
