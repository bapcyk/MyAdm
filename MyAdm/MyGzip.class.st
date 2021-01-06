Class {
	#name : #MyGzip,
	#superclass : #Object,
	#category : #MyAdm
}

{ #category : #utilities }
MyGzip class >> compress: aByteArray [
	"Compress aData, returns compressed data"
	| stream gzStream |
	stream := ByteArray new writeStream binary.
	gzStream := GZipWriteStream on: stream.
	gzStream nextPutAll: aByteArray.
	gzStream close.
	stream close.
	^ stream contents.
]

{ #category : #utilities }
MyGzip class >> compressFile: aPath [
	"Compresses file referred as aPath"
	aPath asFileReference binaryReadStreamDo: [ :stream |
		^ self compress: stream contents
	].

]
