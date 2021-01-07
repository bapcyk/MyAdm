"
I am an abstract command which contains in its presenter FS entries and I am able to recommend how to treat
selected one - as a directory or as a file.
"
Class {
	#name : #MyAbstractFSEntriesCmd,
	#superclass : #MyAbstractCmd,
	#category : #MyAdm
}

{ #category : #testing }
MyAbstractFSEntriesCmd >> isDirectorySelected [
	"Returns true if the selection is a directory entry (or can be treated as it)"
	self subclassResponsibility
]

{ #category : #testing }
MyAbstractFSEntriesCmd >> isFileSelected [
	"Returns true if the selection is a file entry (or can be treated as it)"
	self subclassResponsibility
]
