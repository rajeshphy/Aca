(* ::Package:: *)

(* ================================== *)
(* Begin package context IValues`     *)
(* ================================== *)
BeginPackage["IValues`"]

ClearAll[I0]

I0::usage =
  "I0[m, \[Lambda], \[Alpha], x] returns the auxiliary integral depending on m \
(oscillator index), \[Lambda], parameter \[Alpha], and variable x. Differentiable with respect to x.";

Begin["`Private`"]

(* ===== Full Line Oscillator: \[Alpha] = 0 ===== *)
I0[0, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + Erf[x]);
I0[2, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + (2 Exp[-x^2] x)/(Sqrt[Pi] (1 + 2 x^2)) + Erf[x]);
I0[4, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + (2 Exp[-x^2] x (5 + 2 x^2))/
                             (Sqrt[Pi] (3 + 4 x^2 (3 + x^2))) + Erf[x]);

(* ===== Half Line Oscillator: \[Alpha] = +1/2 ===== *)
I0[0, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/(3 Sqrt[Pi]) + Erf[x] + \[Lambda];
I0[1, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/
                      (5 Sqrt[Pi] (3 + 2 x^2)) + Erf[x] + \[Lambda];
I0[2, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/
                      (7 Sqrt[Pi] (15 + 20 x^2 + 4 x^4)) + Erf[x] + \[Lambda];
I0[3, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (945 + 2520 x^2 + 1512 x^4 +
                      288 x^6 + 16 x^8))/
                      (9 Sqrt[Pi] (105 + 210 x^2 + 84 x^4 + 8 x^6)) + Erf[x] + \[Lambda];

(* ===== Half Line Oscillator: \[Alpha] = -1/2 ===== *)
I0[0, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x)/Sqrt[Pi] + Erf[x] + \[Lambda];
I0[1, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/
                       (3 Sqrt[Pi] (1 + 2 x^2)) + Erf[x] + \[Lambda];
I0[2, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/
                       (5 Sqrt[Pi] (3 + 12 x^2 + 4 x^4)) + Erf[x] + \[Lambda];
I0[3, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/
                       (7 Sqrt[Pi] (15 + 90 x^2 + 60 x^4 + 8 x^6)) + Erf[x] + \[Lambda];

End[]  (* `Private` *)


(* --- Derivative rules for I0 --- *)
(* --- Derivative rule for I0 --- *)
Derivative[0,0,0,n_][I0][m_, \[Lambda]_, \[Alpha]_, x_] :=
  Which[
    IntegerQ[m] && MemberQ[{0, 1, 2, 3, 4}, m] && MemberQ[{0, 1/2, -1/2}, \[Alpha]],
      Module[{expr},
        expr = I0[m, \[Lambda], \[Alpha], x] /. DownValues[I0];
        D[expr, {x, n}]
      ],
    True,
      Derivative[0,0,0,n][UEV[I0]][m, \[Lambda], \[Alpha], x]  (* keep symbolic form *)
  ];


EndPackage[]

