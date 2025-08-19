(* ::Package:: *)

(* ================================== *)
(* Begin package context IValues`     *)
(* ================================== *)
BeginPackage["IValues`"]

I0::usage = "I0[m, λ, α, x] returns the expression for \
the auxiliary integral depending on m (oscillator index), λ, \
parameter α, and variable x.";

Begin["`Private`"]

Clear[I0]

(* Full Line Oscillator: α = 0 *)
I0[0, λ_, 0, x_] := λ + 1/2 (1 + Erf[x]);
I0[2, λ_, 0, x_] := λ + 1/2 (1 + (2 Exp[-x^2] x)/(Sqrt[Pi] (1 + 2 x^2)) + Erf[x]);
I0[4, λ_, 0, x_] := λ + 1/2 (1 + (2 Exp[-x^2] x (5 + 2 x^2))/(Sqrt[Pi] (3 + 4 x^2 (3 + x^2))) + Erf[x]);

(* Half Line Oscillator: α = +1/2 *)
I0[0, λ_, 1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/(3 Sqrt[Pi]) + Erf[x] + λ;
I0[1, λ_, 1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/(5 Sqrt[Pi] (3 + 2 x^2)) + Erf[x] + λ;
I0[2, λ_, 1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/(7 Sqrt[Pi] (15 + 20 x^2 + 4 x^4)) + Erf[x] + λ;
I0[3, λ_, 1/2, x_] := -(2 Exp[-x^2] x (945 + 2520 x^2 + 1512 x^4 + 288 x^6 + 16 x^8))/(9 Sqrt[Pi] (105 + 210 x^2 + 84 x^4 + 8 x^6)) + Erf[x] + λ;

(* Half Line Oscillator: α = -1/2 *)
I0[0, λ_, -1/2, x_] := -(2 Exp[-x^2] x)/Sqrt[Pi] + Erf[x] + λ;
I0[1, λ_, -1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/(3 Sqrt[Pi] (1 + 2 x^2)) + Erf[x] + λ;
I0[2, λ_, -1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/(5 Sqrt[Pi] (3 + 12 x^2 + 4 x^4)) + Erf[x] + λ;
I0[3, λ_, -1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/(7 Sqrt[Pi] (15 + 90 x^2 + 60 x^4 + 8 x^6)) + Erf[x] + λ;

End[] (* `Private` *)

EndPackage[]

