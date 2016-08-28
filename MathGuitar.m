(* ::Package:: *)

(* :Title: MathGuitar Package for Wolfram Mathematica 10+ *)
(* :Context: Utilities`Package` *)
(* :Author: Celestial Phineas @ Zhejiang University *)
(* :Summary: This package provides simple functions for you to
	play a plunked string instrument, such as a steel string
	guitar. 
*)
(* :Package Version: 1.0 *)
(* :Mathematica Version: 10.0 *)
(* :Copyright: Creative Commons Attribution 4.0 International
	(CC BY 4.0) https://creativecommons.org/licenses/by/4.0/
*)
(* :History:
	Version 1.0 Aug 19, 2016, Celestial Phineas
*)
(* :Keywords:
	guitar, music, musical, instrument
*)

BeginPackage["MathGuitar`"]

(*--------Public--------*)
MathGuitar::usage = "Initialize MathGuitar."
SetCapo::usage = "Set the capo."
SetChord::usage = "Set the chord used."
SetInstrument::usage = "Set the instrument used. Currently \"Guitar\"."
SetQuarter::usage = "Set the duration of a quarter note."
ReleaseLeftHand::usage = "Set to the open string state."
GetCapo::usage = "Return the capo position."
GetInstrument::usage = "Return the current instrument."
GetLeftHand::usage = "Return the corrent on-press frets."
GetQuarter::usage = "Return the duration of a quarter note."
PlayNote::usage = "Play a single note."
PlayRightHand::usage = "Play a string."
PlayRightHandSequence::usage = "Play a rhythmic pattern."

(*Unprotect definitions before the Private context.*)
Unprotect[MathGuitar, SetCapo, SetChord, SetInstrument, SetQuarter,
ReleaseLeftHand, GetCapo, GetInstrument, GetLeftHand, GetQuarter,
PlayNote, PlayRightHand, PlayRightHandSequence]

Begin["Private`"]
Needs["Music`"]

ScaleList = {
	"C0", "C#0", "D0", "D#0", "E0", "F0", "F#0", "G0", "G#0", "A0", "A#0", "B0",
	"C1", "C#1", "D1", "D#1", "E1", "F1", "F#1", "G1", "G#1", "A1", "A#1", "B1",
	"C2", "C#2", "D2", "D#2", "E2", "F2", "F#2", "G2", "G#2", "A2", "A#2", "B2",
	"C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3",
	"C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4",
	"C5", "C#5", "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5", "B5",
	"C6", "C#6", "D6", "D#6", "E6", "F6", "F#6", "G6", "G#6", "A6", "A#6", "B6",
	"C7", "C#7", "D7", "D#7", "E7", "F7", "F#7", "G7", "G#7", "A7", "A#7", "B7"
}

FretList = {}
StringList = {}
InstrumentUsed = "Guitar"
SetInstrument[InstrumentName_String:"Guitar"]:=
	Set[InstrumentUsed, InstrumentName]
GetInstrument[]:= InstrumentUsed

QuarterDelay = 0.3
SetQuarter[a_]:= Set[QuarterDelay, a]
GetQuarter[]:= QuarterDelay

Capo = {}
SetCapo[a_]:= Set[Capo, Table[a, Length[FretList]]]
GetCapo[]:= Capo[[1]]

LeftHand={}
SetChord[a_List]:= Set[LeftHand,Capo+a]
ReleaseLeftHand[]:= Set[LeftHand, Capo]
GetLeftHand[]:= LeftHand

ConstructFretList[frets_, a_List]:=
	Table[
		Part[ScaleList, i], {i,
			Span@@
				({# + 1, # + frets})&/@
					Flatten@Table[
						Position[ScaleList, j][[1]],{j,a}]
							}
			]

MathGuitar[Frets_:12,
OpenString_List:{"E4","B3","G3","D3","A2","E2"},
QuarterTime_:QuarterDelay,
CapoToUse_:0]:= Module[{},
	QuarterDelay = QuarterTime;
	FretList = ConstructFretList[Frets, OpenString];
	StringList = OpenString;
	Capo = Table[CapoToUse,Length[FretList]];
	LeftHand = Capo;
]

NoteValueToTimeLength[a_]:= 4/Floor[a]*QuarterDelay*(1+a-Floor[a])

PlayRightHand[StringPlayed_, NoteValue_:4]:=
	EmitSound@Sound@SoundNote[
		If[StringPlayed == 0,
			None,
		(*Else*)
			If[LeftHand[[StringPlayed]] == 0,
				StringList[[StringPlayed]],
			(*Else*)
				FretList[[StringPlayed]][[LeftHand[[StringPlayed]]]]
			]
		], NoteValueToTimeLength[NoteValue], InstrumentUsed
	]

PlayRightHandSequence[RightHandSequence_List]:=
	EmitSound@Sound@
	(SoundNote@@
		Append[#, InstrumentUsed]&/@
			Apply[
				(*Start of the lambda expression.*)
				{(*The first element of the list to return.*)
					If[#1==0,
						None,
					(*Else*)If[LeftHand[[#1]] == 0,
						StringList[[#1]],
					(*Else*)
						FretList[[#1]][[LeftHand[[#1]]]]
					]],
					(*The second element of the list to return.*)
					NoteValueToTimeLength[#2]}&
				(*End of the lambda expression.*),
			RightHandSequence, {1}]
	)

PlayNote[LeftHand_, RightHand_, NoteValue_:4]:=
	If[LeftHand==0,
		EmitSound@Sound@SoundNote[
			StringList[[RightHand]],
			NoteValueToTimeLength[NoteValue],
			InstrumentUsed],
		(*Else*)
		EmitSound@Sound@SoundNote[
			FretList[[RightHand]][[LeftHand]],
			NoteValueToTimeLength[NoteValue],
			InstrumentUsed]
	]
(*Overloading of the function PlayNote*)
PlayNote[NoteName_String, NoteValue_:4]:=
	EmitSound@Sound@SoundNote[NoteName, NoteValue, InstrumentUsed]

End[](*of the context Private.*)

(*Protect the public functions.*)
Protect[MathGuitar, SetCapo, SetChord, SetInstrument, SetQuarter,
ReleaseLeftHand, GetCapo, GetInstrument, GetLeftHand, GetQuarter,
PlayNote, PlayRightHand, PlayRightHandSequence]

EndPackage[]



