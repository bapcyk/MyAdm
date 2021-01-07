"
I am a configuration of the application
"
Class {
	#name : #MyAppConfiguration,
	#superclass : #SpMorphicConfiguration,
	#category : #MyAdm
}

{ #category : #'as yet unclassified' }
MyAppConfiguration >> myStyles [
	^ SpStyleSTONReader fromString: '.application [
    .text [
        Font { #name: "Source Code Pro", #size: 10 }
    ]
]
'
]

{ #category : #styling }
MyAppConfiguration >> styleSheet [
	^ SpStyle defaultStyleSheet, self myStyles
]
