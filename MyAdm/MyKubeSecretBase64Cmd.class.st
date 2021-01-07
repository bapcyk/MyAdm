Class {
	#name : #MyKubeSecretBase64Cmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #accessing }
MyKubeSecretBase64Cmd >> help [
	^ 'Decode selected text with Base64 decoder'
]

{ #category : #initialization }
MyKubeSecretBase64Cmd >> initializeWithExec: anExec [

	"Initializes the command with the executor instance anExec"

	self
		initializeWithName: 'Secret Base64'
		subCmds: { MyKubeApplySecretCmd newCmd: anExec }
		exec: anExec
		parser: MyPlainTextParser new
		presenter: MyTextPresenter

]

{ #category : #testing }
MyKubeSecretBase64Cmd >> isEnabledForSelection: aPresentCmd [
	"Returns boolean flag is the command enbaled for this selection"
	^ aPresentCmd selectedCount = 1
]

{ #category : #utilities }
MyKubeSecretBase64Cmd >> run: anArgs [

	^ anArgs first base64Decoded.

]

{ #category : #running }
MyKubeSecretBase64Cmd >> runUI: anArgs [
	"arg1 - based64 text. arg2 - secretItem. arg3 - pod. arg4 - secret JSON str"
	self contextAt: #secretItem put: anArgs second;
		  contextAt: #pod put: anArgs third;
		  contextAt: #secretJson put: anArgs fourth.
	^ super runUI: anArgs.
]

{ #category : #utilities }
MyKubeSecretBase64Cmd >> selectionAsArgs: aCmdName [
	| contents |
	contents := presenter contents.
	^ contents ifNotNil: [ { contents. context at: #secretItem. context at: #pod. context at: #secretJson. } ]
]
