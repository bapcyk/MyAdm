"
I am a plain text presenter
"
Class {
	#name : #MyTextPresenter,
	#superclass : #MyAbstractPresenter,
	#instVars : [
		'text'
	],
	#category : #MyAdm
}

{ #category : #specs }
MyTextPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #toolbar expand: false;
		add: #text expand: true;
		yourself
]

{ #category : #accessing }
MyTextPresenter >> contents [
	"Returns all contents, not only selected"
	^ text text
]

{ #category : #initialization }
MyTextPresenter >> initialize [
	data := ''.	
	super initialize.
]

{ #category : #initialization }
MyTextPresenter >> initializePresenters [
	"Interface method"
	text := self newText
		"whenSelectionChangedDo: [ :sel | self inform: 'Aaaaa!'. self onSelectionChanged ];"
		addStyle: 'text'.
	super initializePresenters
]

{ #category : #initialization }
MyTextPresenter >> initializeWithParser: aParser cmds: aCmds forCmd: aCmd [
	self initializeWithData: aParser data cmds: aCmds forCmd: aCmd.


]

{ #category : #accessing }
MyTextPresenter >> selection [
	"Returns selection as a list of strings"
	^ { text selectedText }

]

{ #category : #initialization }
MyTextPresenter >> updatePresenter [
	"Interface method"
	"data ifEmpty: [ ^ self ]."
	text text: data asString "trim".
	super updatePresenter.
]
