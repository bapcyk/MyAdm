"
I am an abstract presenter
"
Class {
	#name : #MyAbstractPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'data',
		'cmds',
		'presentCmd',
		'toolbar',
		'windowTitle'
	],
	#category : #MyAdm
}

{ #category : #initialization }
MyAbstractPresenter >> initialize [
	cmds ifNil: [ cmds := #() ].
	data ifNil: [ data := #() ].
	super initialize.
	
]

{ #category : #initialization }
MyAbstractPresenter >> initializePresenters [
	"Interface method: initializes toolbar only"
	toolbar := self newToolbar.
	^ toolbar

]

{ #category : #initialization }
MyAbstractPresenter >> initializeWithData: aData cmds: aCmds forCmd: aCmd [
	data := aData.
	cmds := aCmds.
	presentCmd := aCmd.

]

{ #category : #initialization }
MyAbstractPresenter >> initializeWithParser: aParser cmds: aCmds forCmd: aCmd [
	"Initializes the presenter with a parser and a list of MyAbstractCmd for the toolbar
	and for present command (which results are shown in this presenter)"
	self subclassResponsibility
]

{ #category : #actions }
MyAbstractPresenter >> onCmd: aCmdName event: anEvent button: aButton [

	| cmd found args |
	aButton isEnabled ifFalse: [ ^ self ].
	found := cmds select: [ :c | c name = aCmdName ].
	found ifEmpty: [ ^ nil ].
	cmd := found first.
	args := presentCmd selectionAsArgs: aCmdName.
	anEvent shiftPressed ifTrue: [ self window close ].
	^ cmd runUI: args
]

{ #category : #accessing }
MyAbstractPresenter >> selection [
	"Returns selection as a list of strings"
	self subclassResponsibility
]

{ #category : #TOREMOVE }
MyAbstractPresenter >> title [
	^ windowTitle
]

{ #category : #initialization }
MyAbstractPresenter >> updatePresenter [

	cmds do: [ :cmd | 
		| btn |
		btn := SpToolbarButtonPresenter new
			       label: cmd name;
			       action: [];
			       help: cmd help.
		toolbar addItem: btn.
		btn eventHandler whenMouseDownDo: [ :ev | self onCmd: cmd name event: ev button: btn ] ]

]

{ #category : #accessing }
MyAbstractPresenter >> windowTitle [

	^ windowTitle
]

{ #category : #accessing }
MyAbstractPresenter >> windowTitle: anObject [

	windowTitle := anObject
]
