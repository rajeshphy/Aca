(* ::Package:: *)

(* ================================== *)
(* Begin package context PsiIso`      *)
(* ================================== *)
BeginPackage["PsiIso`"]

ClearAll[Psiiso]

Psiiso::usage ="Psiiso[m, \[Lambda], \[Alpha], x] returns the isospectral wavefunction for index m, \
parameter \[Lambda], deformation \[Alpha] (\[PlusMinus]1/2), and variable x.";

Begin["`Private`"]

(* ================================== *)
(* Half-line oscillator: \[Alpha] = +1/2     *)
(* ================================== *)

Psiiso[0, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/3] E^(-(x^2/2)) x^2 Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (-((2 E^-x^2 x (3+2 x^2))/(3 Sqrt[\[Pi]]))+\[Lambda]+Erf[x]));

Psiiso[1, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/5] E^(-(x^2/2)) x^2 (5/2+x^2) Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (3/2+x^2) (-((2 E^-x^2 x (15+20 x^2+4 x^4))/(5 Sqrt[\[Pi]] (3+2 x^2)))+\[Lambda]+Erf[x]));

Psiiso[2, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/7] E^(-(x^2/2)) x^2 (35+28 x^2+4 x^4) Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (15+20 x^2+4 x^4) (-((2 E^-x^2 x (105+210 x^2+84 x^4+8 x^6))/(7 Sqrt[\[Pi]] (15+20 x^2+4 x^4)))+\[Lambda]+Erf[x]));

Psiiso[3, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2] E^(-(x^2/2)) x^2 (315+378 x^2+108 x^4+8 x^6) Sqrt[\[Lambda] (1+\[Lambda])])/(3 \[Pi]^(1/4) (105+210 x^2+84 x^4+8 x^6) (-((2 E^-x^2 x (945+2520 x^2+1512 x^4+288 x^6+16 x^8))/(9 Sqrt[\[Pi]] (105+210 x^2+84 x^4+8 x^6)))+\[Lambda]+Erf[x]));

(* ================================== *)
(* Half-line oscillator: \[Alpha] = -1/2     *)
(* ================================== *)

Psiiso[0, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (-((2 E^-x^2 x)/Sqrt[\[Pi]])+\[Lambda]+Erf[x]));

Psiiso[1, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (3/2+x^2) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[3] \[Pi]^(1/4) (1/2+x^2) (-((2 E^-x^2 x (3+2 x^2))/(3 Sqrt[\[Pi]] (1+2 x^2)))+\[Lambda]+Erf[x]));

Psiiso[2, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (15+20 x^2+4 x^4) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[5] \[Pi]^(1/4) (3+12 x^2+4 x^4) (-((2 E^-x^2 x (15+20 x^2+4 x^4))/(5 Sqrt[\[Pi]] (3+12 x^2+4 x^4)))+\[Lambda]+Erf[x]));

Psiiso[3, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (105+210 x^2+84 x^4+8 x^6) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[7] \[Pi]^(1/4) (15+90 x^2+60 x^4+8 x^6) (-((2 E^-x^2 x (105+210 x^2+84 x^4+8 x^6))/(7 Sqrt[\[Pi]] (15+90 x^2+60 x^4+8 x^6)))+\[Lambda]+Erf[x]));

End[]   (* `Private` *)
EndPackage[]

