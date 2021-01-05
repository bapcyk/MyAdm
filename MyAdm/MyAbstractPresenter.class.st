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
	super initializePresenters.	
	^ toolbar

]

{ #category : #initialization }
MyAbstractPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialExtent: 650@400.
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

{ #category : #actions }
MyAbstractPresenter >> onSelectionChanged [
	"Should be called by successor-presenter to update buttons states"
	| selSize |
	selSize := self selection ifNil: [ 0 ] ifNotNil: [ self selection size ].
	1 to: cmds size do: [ :i |
		(cmds at: i) requiredSelectionSize <= selSize
			ifTrue: [ (toolbar items at: i) enable ]
			ifFalse: [ (toolbar items at: i) disable ]
	].
]

{ #category : #accessing }
MyAbstractPresenter >> selection [
	"Returns selection as a list of items (chars, lists, etc - depends on the concrete presenter)"
	self subclassResponsibility
]

{ #category : #TOREMOVE }
MyAbstractPresenter >> title [
	^ windowTitle
]

{ #category : #initialization }
MyAbstractPresenter >> updatePresenter [
	"Successors must call it (`super updatePresenter`) after own implementation"
	
	super updatePresenter.	
	cmds do: [ :cmd | 
		| btn |
		btn := SpToolbarButtonPresenter new
			       label: cmd name;
			       action: [];
			       help: cmd help.
		toolbar addItem: btn.
		btn eventHandler whenMouseDownDo: [ :ev | self onCmd: cmd name event: ev button: btn ] ].

	self onSelectionChanged.

]

{ #category : #accessing }
MyAbstractPresenter >> windowTitle [

	^ windowTitle
]

{ #category : #accessing }
MyAbstractPresenter >> windowTitle: anObject [

	windowTitle := anObject
]
