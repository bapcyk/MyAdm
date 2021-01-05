"
I am a Spec table presenter
"
Class {
	#name : #MyTablePresenter,
	#superclass : #MyAbstractPresenter,
	#instVars : [
		'table',
		'header',
		'selectedRows'
	],
	#category : #MyAdm
}

{ #category : #specs }
MyTablePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #toolbar expand: false;
		add: #table expand: true fill: true;
		yourself
]

{ #category : #initialization }
MyTablePresenter >> initialize [
	header := #().
	data := #().	
	selectedRows := OrderedCollection new.
	super initialize.
]

{ #category : #initialization }
MyTablePresenter >> initializePresenters [
	"Interface method"
	table := self newTable beResizable beSingleSelection.
	super initializePresenters.

]

{ #category : #initialization }
MyTablePresenter >> initializeWithParser: aParser cmds: aCmds forCmd: aCmd [
	self initializeWithData: aParser data cmds: aCmds forCmd: aCmd.
	header := aParser header.

]

{ #category : #accessing }
MyTablePresenter >> selection [
	"Returns selection as a list of strings"
	^ selectedRows ifEmpty: [ nil ] ifNotEmpty: [ selectedRows ].

]

{ #category : #initialization }
MyTablePresenter >> updatePresenter [
	"Interface method"
	| columnAs |

	data ifEmpty: [ ^ self ].

	columnAs := [ :iCol :row | row at: iCol ].
	table items: data.

	cmds ifNotEmpty: [
		table addColumn: ((SpCheckBoxTableColumn title: ' ' evaluated: [ :row | false ]) width: 20;
					onActivation: [ :row | 
						selectedRows add: row.
						self onSelectionChanged.
					];
					onDeactivation: [ :row | 
						selectedRows remove: row.
						self onSelectionChanged.
					]).
	].

	header doWithIndex: [ :headerColumn :headerIndex |
			table addColumn: (
				(SpStringTableColumn title: headerColumn evaluated: [ :row | columnAs value: headerIndex value: row ])
				width: headerColumn size * 10 + 20; beExpandable)
	].

	super updatePresenter.


]
