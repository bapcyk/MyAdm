"
It's the same as `MyKubeCatCmd` but decodes output from UTF-8
"
Class {
	#name : #MyKubeCatUtf8Cmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeCatUtf8Cmd >> help [
	^ 'File content as UTF8'
]

{ #category : #initialization }
MyKubeCatUtf8Cmd >> initializeWithExec: anExec [
	"Initializes the command with the executor instance anExec"
	self
		initializeWithName: 'Cat UTF8'
		subCmds: #( )
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #accessing }
MyKubeCatUtf8Cmd >> requiredSelectionSize [
	^ 1
]

{ #category : #utilities }
MyKubeCatUtf8Cmd >> run: anArgs [
	| pod path |
	pod := anArgs first.
	path := anArgs second.
	^ exec exec: { '<REMOTE-BIN>/kubectl'. 'exec'. '-i'. pod. 'cat'. path. }

]

{ #category : #running }
MyKubeCatUtf8Cmd >> runUI: anArgs [
	extTitle := anArgs second.
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeCatUtf8Cmd >> selectionAsArgs: aCmdName [
	| sel |
	sel := presenter selection.
	^ sel ifNotNil: [ sel ]
]
