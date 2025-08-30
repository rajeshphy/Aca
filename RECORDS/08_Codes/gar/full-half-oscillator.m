(* ::Package:: *)

(* ============================================== *)
(*  Package: full-half-oscillator.m                         *)
(*  Full Line Oscillator and Half Line Oscillator *)
(*  Author: (Rajesh Kumar / Supersymmetry / 22-08-2025)            *)
(* ============================================== *)

BeginPackage["oscillator`"]

(* Usage messages *)
Vflo::usage      = "Vflo[sln, x, \[Omega]x] gives the RE-potential of the Full Line Oscillator. sln used instead of m as it gets twice so sln=1 is 2m"
Vhlo::usage      = "Vhlo[m, \[Alpha], x, \[Omega]x] gives the RE-potential of the Half Line Oscillator."
Vhiso::usage ="Viso[m, \[Lambda], \[Alpha], x] returns the isospectral potential V_m^{iso}(x;\[Lambda],\[Alpha]). \
Implemented for m = 0..3 and \[Alpha] = \[PlusMinus]1/2.";

\[Psi]flo::usage      = "\[Psi]flo[n, sln, x, \[Omega]x] unified function: ground (n=0) or excited state. sln used instead of m as it gets twice so sln=1 is 2m"
\[Psi]hlo::usage      = "\[Psi]hlo[n, m, \[Alpha], x, \[Omega]x] gives the wavefunction of the Half Line Oscillator."
\[Psi]hiso::usage ="\[Psi]hiso[m, \[Lambda], \[Alpha], x] returns the isospectral wavefunction for index m, \
(\[Alpha]=0,m=0,2,4 and for \[Alpha]=\[PlusMinus]1/2,m=0,1,2,3).";

I0::usage ="I0[m, \[Lambda], \[Alpha], x] returns the auxiliary integral depending on m \
(\[Alpha]=0,m=0,2,4 and for \[Alpha]=\[PlusMinus]1/2,m=0,1,2,3). Differentiable with respect to x.";

Begin["`Private`"]


(* =============== FULL LINE OSCILLATOR =============== *)

Vflo[sln_, x_, \[Omega]x_] := 
  1/4 \[Omega]x (-4 - 8 sln + x^2 \[Omega]x - 
     (64 sln^2 HermiteH[-1 + 2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]]^2)/
      HermiteH[2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]]^2 + 
     (8 sln ((-2 + 4 sln) HermiteH[-2 + 2 sln, 
          (x Sqrt[-\[Omega]x])/Sqrt[2]] + 
         Sqrt[2] x Sqrt[-\[Omega]x] HermiteH[-1 + 2 sln, (x Sqrt[-\[Omega]x])/Sqrt[
            2]]))/HermiteH[2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]]);


Vfiso[0, \[Lambda]_, 1/2, x_] :=-2+x^2+(8 E^(-2 x^2))/(\[Pi] (1+2 \[Lambda]+Erf[x])^2)+(8 E^-x^2 x)/(Sqrt[\[Pi]] (1+2 \[Lambda]+Erf[x]));
Vfiso[2, \[Lambda]_, 1/2, x_] :=(4 (8-2 x^2+x^4)+4 E^x^2 Sqrt[\[Pi]] x (10-3 x^2+2 x^4) (1+2 \[Lambda]+Erf[x])+E^(2 x^2) \[Pi] (-10+9 x^2-4 x^4+4 x^6) (1+2 \[Lambda]+Erf[x])^2)/(2 x+E^x^2 Sqrt[\[Pi]] (1+2 x^2) (1+2 \[Lambda]+Erf[x]))^2;
Vfiso[4, \[Lambda]_, 1/2, x_] :=(4 (128-34 x^2+17 x^4+12 x^6+4 x^8)+4 E^x^2 Sqrt[\[Pi]] x (162-53 x^2+42 x^4+28 x^6+8 x^8) (1+2 \[Lambda]+Erf[x])+E^(2 x^2) \[Pi] (-162+153 x^2+8 x^4 (-9+13 x^2+8 x^4+2 x^6)) (1+2 \[Lambda]+Erf[x])^2)/(2 x (5+2 x^2)+E^x^2 Sqrt[\[Pi]] (3+4 x^2 (3+x^2)) (1+2 \[Lambda]+Erf[x]))^2;


\[Psi]flo[n_, sln_, x_, \[Omega]x_] := 
  If[n == 0,
    (* ---- Ground state ---- *)
    Sqrt[(2^(2 sln) (2 sln)!)/Sqrt[2 \[Pi]]] E^((-\[Omega]x x^2)/4)/
   HermiteH[2 sln, (Sqrt[-(\[Omega]x/2)] x)],
    (* ---- Excited states (n>0) ---- *)
    (E^(-((x^2 \[Omega]x)/4)) 
       Sqrt[(2^(1/2 - (n - 1)) Sqrt[\[Omega]x])/((n - 1)!)] 
       (-2 (n - 1) Sqrt[\[Omega]x] 
          HermiteH[-1 + (n - 1), (x Sqrt[\[Omega]x])/Sqrt[2]] 
          HermiteH[2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]] + 
        HermiteH[(n - 1), (x Sqrt[\[Omega]x])/Sqrt[2]] (
          Sqrt[2] x \[Omega]x HermiteH[2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]] + 
          4 sln Sqrt[-\[Omega]x] 
            HermiteH[-1 + 2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]]))
     )/(2 \[Pi]^(1/4) Sqrt[(1 + (n - 1) + 2 sln) \[Omega]x] 
       HermiteH[2 sln, (x Sqrt[-\[Omega]x])/Sqrt[2]])
  ];

I0[0, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + Erf[x]);
I0[2, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + (2 Exp[-x^2] x)/(Sqrt[Pi] (1 + 2 x^2)) + Erf[x]);
I0[4, \[Lambda]_, 0, x_] := \[Lambda] + 1/2 (1 + (2 Exp[-x^2] x (5 + 2 x^2))/
                             (Sqrt[Pi] (3 + 4 x^2 (3 + x^2))) + Erf[x]);
(* =============== HALF LINE OSCILLATOR =============== *)

Vhlo[m_, \[Alpha]_, x_, \[Omega]x_] := 
  (8 x^4 \[Omega]x^2 LaguerreL[-1 + m, 1 + \[Alpha], -(x^2 \[Omega]x/2)]^2 + 
     4 x^2 \[Omega]x (2 \[Alpha] + x^2 \[Omega]x) LaguerreL[-1 + m, 1 + \[Alpha], -(x^2 \[Omega]x/2)] 
       LaguerreL[m, \[Alpha], -(x^2 \[Omega]x/2)] + 
     LaguerreL[m, \[Alpha], -(x^2 \[Omega]x/2)] (-4 x^4 \[Omega]x^2 LaguerreL[-2 + m, 
          2 + \[Alpha], -(x^2 \[Omega]x/2)] + (3 + 8 \[Alpha] + 4 \[Alpha]^2 + x^4 \[Omega]x^2 - 
           4 x^2 (\[Omega]x + 2 m \[Omega]x)) 
         LaguerreL[m, \[Alpha], -(x^2 \[Omega]x/2)]))/(4 x^2 LaguerreL[
      m, \[Alpha], -(x^2 \[Omega]x/2)]^2);

\[Psi]hlo[n_, m_, \[Alpha]_, x_, \[Omega]x_] := 
  (E^(-((x^2 \[Omega]x)/4)) x^(3/2 + \[Alpha]) \[Omega]x 
     Sqrt[(2^-\[Alpha] \[Omega]x^(1 + \[Alpha]) n!)/Gamma[1 + n + \[Alpha]]] (LaguerreL[-1 + m, 
         1 + \[Alpha], -(x^2 \[Omega]x/2)] LaguerreL[n, \[Alpha], (x^2 \[Omega]x)/2] + 
      LaguerreL[m, \[Alpha], -(x^2 \[Omega]x/2)] (LaguerreL[-1 + n, 1 + \[Alpha], (x^2 \[Omega]x)/2] + 
         LaguerreL[n, \[Alpha], (x^2 \[Omega]x)/2])))/(Sqrt[2] 
     Sqrt[(1 + m + n + \[Alpha]) \[Omega]x] LaguerreL[m, \[Alpha], -(x^2 \[Omega]x/2)]);

(* ================================== *)
(* Half-line oscillator: \[Alpha] = +1/2     *)
(* ================================== *)

Vhiso[0, \[Lambda]_, 1/2, x_] :=-8+2/x^2+x^2+(128 x^8)/(6 x+4 x^3-3 E^x^2 Sqrt[\[Pi]] (\[Lambda]+Erf[x]))^2-(32 x^3 (-2+x^2))/(6 x+4 x^3-3 E^x^2 Sqrt[\[Pi]] (\[Lambda]+Erf[x]));

Vhiso[1, \[Lambda]_, 1/2, x_] :=(4 x^2 (450-2100 x^2-2335 x^4+8 x^6 (-255-51 x^2+4 x^4+2 x^6))+20 E^x^2 Sqrt[\[Pi]] x (-90+480 x^2+531 x^4+430 x^6+140 x^8+24 x^10) (\[Lambda]+Erf[x])+25 E^(2 x^2) \[Pi] (18-108 x^2-111 x^4-36 x^6+4 x^8) (\[Lambda]+Erf[x])^2)/(x^2 (30 x+8 x^3 (5+x^2)-5 E^x^2 Sqrt[\[Pi]] (3+2 x^2) (\[Lambda]+Erf[x]))^2);

Vhiso[2, \[Lambda]_, 1/2, x_] :=(4 x^2 (22050-147000 x^2-367255 x^4+4 x^6 (-122395-66717 x^2+4 x^4 (-3962-237 x^2+36 x^4+4 x^6)))+28 E^x^2 Sqrt[\[Pi]] x (-3150+23100 x^2+55545 x^4+2 x^6 (33235+17780 x^2+5208 x^4+776 x^6+48 x^8)) (\[Lambda]+Erf[x])+49 E^(2 x^2) \[Pi] (450-3600 x^2-8175 x^4+8 x^6 (-885-235 x^2-12 x^4+2 x^6)) (\[Lambda]+Erf[x])^2)/(x^2 (4 x^2 (105+210 x^2+84 x^4+8 x^6)^2-28 E^x^2 Sqrt[\[Pi]] x (105+210 x^2+84 x^4+8 x^6) (15+4 x^2 (5+x^2)) (\[Lambda]+Erf[x])+49 E^(2 x^2) \[Pi] (15+4 x^2 (5+x^2))^2 (\[Lambda]+Erf[x])^2));

Vhiso[3, \[Lambda]_, 1/2, x_] :=(4 x^2 (1786050-15479100 x^2-59753295 x^4+16 x^6 (-6894720-5818743 x^2-2528568 x^4-563562 x^6+16 x^8 (-3528-25 x^2+20 x^4+x^6)))+36 E^x^2 Sqrt[\[Pi]] x (-198450+1852200 x^2+6886215 x^4+2 x^6 (5805135+4584090 x^2+1999620 x^4+8 x^6 (63189+9290 x^2+732 x^4+24 x^6))) (\[Lambda]+Erf[x])+81 E^(2 x^2) \[Pi] (22050-220500 x^2-782775 x^4+4 x^6 (-274155-156765 x^2+4 x^4 (-10038-973 x^2+4 x^4+4 x^6))) (\[Lambda]+Erf[x])^2)/(x^2 (2 x (945+8 x^2 (315+189 x^2+36 x^4+2 x^6))-9 E^x^2 Sqrt[\[Pi]] (105+210 x^2+84 x^4+8 x^6) (\[Lambda]+Erf[x]))^2);


\[Psi]hiso[0, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/3] E^(-(x^2/2)) x^2 Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (-((2 E^-x^2 x (3+2 x^2))/(3 Sqrt[\[Pi]]))+\[Lambda]+Erf[x]));

\[Psi]hiso[1, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/5] E^(-(x^2/2)) x^2 (5/2+x^2) Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (3/2+x^2) (-((2 E^-x^2 x (15+20 x^2+4 x^4))/(5 Sqrt[\[Pi]] (3+2 x^2)))+\[Lambda]+Erf[x]));

\[Psi]hiso[2, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2/7] E^(-(x^2/2)) x^2 (35+28 x^2+4 x^4) Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (15+20 x^2+4 x^4) (-((2 E^-x^2 x (105+210 x^2+84 x^4+8 x^6))/(7 Sqrt[\[Pi]] (15+20 x^2+4 x^4)))+\[Lambda]+Erf[x]));

\[Psi]hiso[3, \[Lambda]_, 1/2, x_] :=(2 Sqrt[2] E^(-(x^2/2)) x^2 (315+378 x^2+108 x^4+8 x^6) Sqrt[\[Lambda] (1+\[Lambda])])/(3 \[Pi]^(1/4) (105+210 x^2+84 x^4+8 x^6) (-((2 E^-x^2 x (945+2520 x^2+1512 x^4+288 x^6+16 x^8))/(9 Sqrt[\[Pi]] (105+210 x^2+84 x^4+8 x^6)))+\[Lambda]+Erf[x]));

I0[0, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/(3 Sqrt[Pi]) + Erf[x] + \[Lambda];
I0[1, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/
                      (5 Sqrt[Pi] (3 + 2 x^2)) + Erf[x] + \[Lambda];
I0[2, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/
                      (7 Sqrt[Pi] (15 + 20 x^2 + 4 x^4)) + Erf[x] + \[Lambda];
I0[3, \[Lambda]_, 1/2, x_] := -(2 Exp[-x^2] x (945 + 2520 x^2 + 1512 x^4 +
                      288 x^6 + 16 x^8))/
                      (9 Sqrt[Pi] (105 + 210 x^2 + 84 x^4 + 8 x^6)) + Erf[x] + \[Lambda];


(* ================================== *)
(* Half-line oscillator: \[Alpha] = -1/2     *)
(* ================================== *)

Vhiso[0, \[Lambda]_, -1/2, x_] :=(4 x^2 (4+x^2)+12 E^x^2 Sqrt[\[Pi]] x^3 (\[Lambda]+Erf[x])+E^(2 x^2) \[Pi] (-4+x^2) (\[Lambda]+Erf[x])^2)/(-2 x+E^x^2 Sqrt[\[Pi]] (\[Lambda]+Erf[x]))^2;

Vhiso[1, \[Lambda]_, -1/2, x_] :=(4 x^2 (8+x^2) (3+2 x^2)^2+12 E^x^2 Sqrt[\[Pi]] x (3+2 x^2) (4+19 x^2+6 x^4) (\[Lambda]+Erf[x])+9 E^(2 x^2) \[Pi] (-16-15 x^2-28 x^4+4 x^6) (\[Lambda]+Erf[x])^2)/(6 x+4 x^3-3 E^x^2 Sqrt[\[Pi]] (1+2 x^2) (\[Lambda]+Erf[x]))^2;

Vhiso[2, \[Lambda]_, -1/2, x_] :=(4 x^2 (12+x^2) (15+4 x^2 (5+x^2))^2+20 E^x^2 Sqrt[\[Pi]] x (24+153 x^2+100 x^4+12 x^6) (15+4 x^2 (5+x^2)) (\[Lambda]+Erf[x])+25 E^(2 x^2) \[Pi] (-252-567 x^2-1752 x^4-856 x^6-96 x^8+16 x^10) (\[Lambda]+Erf[x])^2)/(4 x^2 (15+4 x^2 (5+x^2))^2-20 E^x^2 Sqrt[\[Pi]] x (3+4 x^2 (3+x^2)) (15+4 x^2 (5+x^2)) (\[Lambda]+Erf[x])+25 E^(2 x^2) \[Pi] (3+4 x^2 (3+x^2))^2 (\[Lambda]+Erf[x])^2);

Vhiso[3, \[Lambda]_, -1/2, x_] :=(4 x^2 (16+x^2) (105+210 x^2+84 x^4+8 x^6)^2+84 E^x^2 Sqrt[\[Pi]] x (105+210 x^2+84 x^4+8 x^6) (60+495 x^2+490 x^4+124 x^6+8 x^8) (\[Lambda]+Erf[x])+49 E^(2 x^2) \[Pi] (-9000-32175 x^2+4 x^4 (-35325-37365 x^2+4 x^4 (-3990-597 x^2-4 x^4+4 x^6))) (\[Lambda]+Erf[x])^2)/(2 x (105+210 x^2+84 x^4+8 x^6)-7 E^x^2 Sqrt[\[Pi]] (15+90 x^2+60 x^4+8 x^6) (\[Lambda]+Erf[x]))^2;

\[Psi]hiso[0, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x Sqrt[\[Lambda] (1+\[Lambda])])/(\[Pi]^(1/4) (-((2 E^-x^2 x)/Sqrt[\[Pi]])+\[Lambda]+Erf[x]));

\[Psi]hiso[1, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (3/2+x^2) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[3] \[Pi]^(1/4) (1/2+x^2) (-((2 E^-x^2 x (3+2 x^2))/(3 Sqrt[\[Pi]] (1+2 x^2)))+\[Lambda]+Erf[x]));

\[Psi]hiso[2, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (15+20 x^2+4 x^4) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[5] \[Pi]^(1/4) (3+12 x^2+4 x^4) (-((2 E^-x^2 x (15+20 x^2+4 x^4))/(5 Sqrt[\[Pi]] (3+12 x^2+4 x^4)))+\[Lambda]+Erf[x]));

\[Psi]hiso[3, \[Lambda]_, -1/2, x_] :=(2 E^(-(x^2/2)) x (105+210 x^2+84 x^4+8 x^6) Sqrt[\[Lambda] (1+\[Lambda])])/(Sqrt[7] \[Pi]^(1/4) (15+90 x^2+60 x^4+8 x^6) (-((2 E^-x^2 x (105+210 x^2+84 x^4+8 x^6))/(7 Sqrt[\[Pi]] (15+90 x^2+60 x^4+8 x^6)))+\[Lambda]+Erf[x]));

I0[0, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x)/Sqrt[Pi] + Erf[x] + \[Lambda];
I0[1, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (3 + 2 x^2))/
                       (3 Sqrt[Pi] (1 + 2 x^2)) + Erf[x] + \[Lambda];
I0[2, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (15 + 20 x^2 + 4 x^4))/
                       (5 Sqrt[Pi] (3 + 12 x^2 + 4 x^4)) + Erf[x] + \[Lambda];
I0[3, \[Lambda]_, -1/2, x_] := -(2 Exp[-x^2] x (105 + 210 x^2 + 84 x^4 + 8 x^6))/
                       (7 Sqrt[Pi] (15 + 90 x^2 + 60 x^4 + 8 x^6)) + Erf[x] + \[Lambda];

End[]

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

