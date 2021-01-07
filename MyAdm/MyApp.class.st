"
I am an application class (it's used to create presenters with configuration: styles, see `MyAbstractCmd` `#runUI:`)
"
Class {
	#name : #MyApp,
	#superclass : #SpApplication,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #MyAdm
}

{ #category : #initialization }
MyApp >> initialize [
	super initialize.
	self useBackend: #Morphic with: MyAppConfiguration new.
]
