"
I am a successor of `LibC` - with additional methods.
"
Class {
	#name : #MyLibC,
	#superclass : #LibC,
	#category : #MyAdm
}

{ #category : #'api - piping' }
MyLibC >> fflush: aPipe [
	^self ffiCall: #(int fflush(ExternalAddress *aPipe)).

]

{ #category : #'api - piping' }
MyLibC >> fputs: aStr pipe: aPipe [
	"Puts string."
	^self ffiCall: #(int fputs(char* aStr, ExternalAddress *aPipe))

]

{ #category : #'api - piping' }
MyLibC >> fwrite: aData size: aSize count: aCount pipe: aPipe [
	"Write string."
	^self ffiCall: #(int fwrite(void* aData, int aSize, int aCount, ExternalAddress *aPipe))

]

{ #category : #'api - piping' }
MyLibC >> fwrite: aData size: aSize pipe: aPipe [
	"Write string."
	| itemSize |
	itemSize := 1.
	^self ffiCall: #(int fwrite(void* aData, int itemSize, int aSize, ExternalAddress *aPipe))

]
