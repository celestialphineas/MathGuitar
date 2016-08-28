# MathGuitar Package for Mathematica 10.0+

This package provides a simple frame for you to play the guitar with a few 
functions. This can be especially useful when you build a model or an application
where guitar-playing is needed.

## Demo

[Demo Video, Arduino x Mathematica](http://v.youku.com/v_show/id_XMTcwMjAxNzYzMg)

## Usage

### Initialization

Before using the functions in the package, you will have to first import the
package in the Mathematica book (.nb) which is corrently in the session.

```mathematica
<< "<path>"
MathGuitar[];   (* Intialization Function *)
```

The `<path>` is the location where you downloaded the package. For example, 
`"C:\\Users\\Public\\Desktop\\MathGuitar.m"`
For more information, see:

* [Get - Wolfram Language](http://reference.wolfram.com/language/ref/Get.html)

### Functions

#### MathGuitar

```mathematica
MathGuitar[             (* Default arguments *)
    Frets_:             12,
    OpenString_List:    {"E4","B3","G3","D3","A2","E2"},
    QuarterTime_:       QuarterDelay,
    CapoToUse_:         0
    ]
```

The `MathGuitar` function is the initialization function of the package. 

* Frets_	        The maximum number of frets can be used.
* OpenString_List	Open string notes. The length of the list can be decided by 
yourself.
* QuaterTime_       Time length of a quater note.
* CapoToUse_        The capo position.

#### SetChord and the notation of a chord

```mathematica
SetChord[chord_List]
```

Set a chord. The notation of a chord is a list looks like:

```mathematica
Dsus2 = {0, 3, 2, 0, 0, 0};
```

It defines a chord called Dsus2, like this:

```
x x o     o
+-+-+-+-+-+
| | | | | |
+-+-+-+-+-+
| | | 1 | |
+-+-+-+-+-+
| | | | 3 |
+-+-+-+-+-+
| | | | | |
+-+-+-+-+-+
```

The `SetChord` function does not emit any sound. It just set the chord as what 
your left hand do.

#### Notation of a note value

two hundred fifty-sixth note        256
hundred twenty-eighth note          128
sixty-fourth note                   64
thirty-second note                  32
sixteenth note                      16
eighth note                         8
quarter note	                    4
half note                           2
whole note                          1
(double whole and longa are not supported)
quarter note with a dot             4.5
...

The above notation can be used for function arguments.

#### PlayNote

```mathematica
PlayNote[LeftHand_, RightHand_, NoteValue_: 4]
(* Overloading of the function PlayNote *)
PlayNote[NoteName_String, NoteValue_:4]
```

Play a single note. For example:

```mathematica
PlayNote[2, 3, 4]
(* Fret 2, string 3, quarter note *)
PlayNote["C4"]
(* C4 quarter note *)
```

**Note that functions with the prefix "Play" emit sounds immediately when the function is called.**

#### PlayRightHandSequence and the notation of a rhythm

```mathematica
PlayRightHandSequence[RightHandSequence_List]
```

The notation of a rhythmic pattern, or a "right hand sequence", the term used in
the package, is as follows.

```mathematica
rhythm1 = 
{{4, 4}, {3, 4}, {1, 4}, {2, 4}, {1, 4}, {2, 4}, {3, 4}, {2, 4}};
```

```
1 |-------x-----x-----------|
2 |----------x-----x-----x--|
3 |-----x-------------x-----|
4 |--x----------------------|
5 |-------------------------|
6 |-------------------------|
```

## And...

Oops, it's getting a bit too long! Even longer than the package. Just see the code.

### Known issues

Strums, tremolos, glissandos, ... are not supported.

### Contact

celestialphineas [AT] hotmail [DOT] com