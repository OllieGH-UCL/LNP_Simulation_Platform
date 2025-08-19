// Mesh Coarseness (scalar) - 0.1 causes errors!
lc = 0.1;


// ==== Points ====
// Vertical bar points
Point(1) = {0, 0, 0, lc};
Point(2) = {1, 0, 0, lc};
Point(3) = {1, 3, 0, lc};
Point(4) = {0, 3, 0, lc};

// Top bar points (centered on vertical bar)
Point(5) = {-1, 3, 0, lc};
Point(6) = {2, 3, 0, lc};
Point(7) = {2, 4, 0, lc};
Point(8) = {-1, 4, 0, lc};

// Baffle 1-2
Point(9)  = {0.5, 2.5, 0, lc};
Point(10) = {0, 2.5, 0, lc};
Point(11) = {0.5, 3, 0, lc};
Point(12) = {0, 2, 0, lc};
Point(13) = {1, 2.5, 0, lc};
Point(14) = {0.5, 2, 0, lc};
Point(15) = {1, 2, 0, lc};
Point(16) = {0.5, 1.5, 0, lc};
Point(17) = {0.5, 1, 0, lc};
Point(18) = {0, 1.5, 0, lc};
Point(19) = {0, 1, 0, lc};
Point(20) = {1, 1.5, 0, lc};
Point(21) = {1, 1, 0, lc};
Point(22) = {1, 0.5, 0, lc};
Point(23) = {0.5, 0.5, 0, lc};
Point(24) = {0, 0.5, 0, lc};
Point(25) = {0.5, 0, 0, lc};
// Baffle 3-4
Point(26) = {0, -0.5, 0, lc};
Point(27) = {0.5, -0.5, 0, lc};
Point(28) = {1, -0.5, 0, lc};
Point(29) = {0, -1, 0, lc};
Point(30) = {0.5, -1, 0, lc};
Point(31) = {1, -1, 0, lc};
Point(32) = {0, -1.5, 0, lc};
Point(33) = {0.5, -1.5, 0, lc};
Point(34) = {1, -1.5, 0, lc};
Point(35) = {0, -2, 0, lc};
Point(36) = {0.5, -2, 0, lc};
Point(37) = {1, -2, 0, lc};
// Baffle 4-6
Point(38) = {0, -2.5, 0, lc};
Point(39) = {0.5, -2.5, 0, lc};
Point(40) = {1, -2.5, 0, lc};
Point(41) = {0, -3, 0, lc};
Point(42) = {0.5, -3, 0, lc};
Point(43) = {1, -3, 0, lc};
Point(44) = {0, -3.5, 0, lc};
Point(45) = {0.5, -3.5, 0, lc};
Point(46) = {1, -3.5, 0, lc};
Point(47) = {0, -4, 0, lc};
Point(48) = {0.5, -4, 0, lc};
Point(49) = {1, -4, 0, lc};
// Baffle 6-8
Point(50) = {0, -4.5, 0, lc};
Point(51) = {0.5, -4.5, 0, lc};
Point(52) = {1, -4.5, 0, lc};
Point(53) = {0, -5, 0, lc};
Point(54) = {0.5, -5, 0, lc};
Point(55) = {1, -5, 0, lc};
Point(56) = {0, -5.5, 0, lc};
Point(57) = {0.5, -5.5, 0, lc};
Point(58) = {1, -5.5, 0, lc};
Point(59) = {0, -6, 0, lc};
Point(60) = {0.5, -6, 0, lc};
Point(61) = {1, -6, 0, lc};
// Baffle 8-9
Point(62) = {0, -6.5, 0, lc};
Point(63) = {0.5, -6.5, 0, lc};
Point(64) = {1, -6.5, 0, lc};
Point(65) = {0, -7, 0, lc};
Point(66) = {0.5, -7, 0, lc};
Point(67) = {1, -7, 0, lc};
Point(68) = {0.5, -7.5, 0, lc};
Point(69) = {1, -7.5, 0, lc};





// ==== Lines ====
// Outer bounding lines (top bar + vertical bar)
Line(1)  = {8, 7};
Line(2)  = {7, 6};
Line(3)  = {6, 3};
Line(4)  = {8, 5};
Line(5)  = {5, 4};
Line(21) = {24, 1};
Line(22) = {22, 2};
Line(23) = {2, 25};

// Lines connecting baffle and interior points
Line(6)  = {3, 13};
Line(7)  = {11, 9};
Line(8)  = {9, 10};
Line(9)  = {10, 12};
Line(10) = {13, 15};
Line(11) = {15, 14};
Line(12) = {12, 18};
Line(13) = {14, 16};
Line(14) = {16, 20};
Line(15) = {18, 19};
Line(16) = {19, 17};
Line(17) = {20, 21};
Line(18) = {21, 22};
Line(19) = {17, 23};
Line(20) = {23, 24};
Line(24) = {4, 11};

// ==== Curve Loop & Plane Surface ====
Curve Loop(1) = {
    24, 7, 8, 9, 12, 15, 16, 19, 20, 21, 25,
    -23, -22, -18, -17, -14, -13, -11, -10,
    -6, -3, -2, -1, 4, 5
};

//+
//Plane Surface(1) = {1};
//+
//out[] = Extrude {0, 0, 0.1} { Surface{1}; };
//+
// Physical Volume (extruded 3D volume)
//Physical Volume("fluid", 100) = {out[1]};

//+
Line(25) = {1, 26};
//+
Line(26) = {25, 27};
//+
Line(27) = {26, 29};
//+
Line(28) = {27, 28};
//+
Line(29) = {29, 30};
//+
Line(30) = {28, 31};
//+
Line(31) = {31, 34};
//+
Line(32) = {30, 33};
//+
Line(33) = {34, 37};
//+
Line(34) = {33, 32};
//+
Line(35) = {37, 36};
//+
Line(36) = {32, 35};
//+
Line(37) = {35, 38};
//+
Line(38) = {36, 39};
//+
Line(39) = {39, 40};
//+
Line(40) = {38, 41};
//+
Line(41) = {41, 42};
//+
Line(42) = {40, 43};
//+
Line(43) = {43, 46};
//+
Line(44) = {42, 45};
//+
Line(45) = {46, 49};
//+
Line(46) = {45, 44};
//+
Line(47) = {49, 48};
//+
Line(48) = {44, 47};
//+
Line(49) = {47, 50};
//+
Line(50) = {48, 51};
//+
Line(51) = {50, 53};
//+
Line(52) = {51, 52};
//+
Line(53) = {52, 55};
//+
Line(54) = {53, 54};
//+
Line(55) = {55, 58};
//+
Line(56) = {54, 57};
//+
Line(57) = {57, 56};
//+
Line(58) = {58, 61};
//+
Line(59) = {56, 59};
//+
Line(60) = {61, 60};
//+
Line(61) = {59, 62};
//+
Line(62) = {60, 63};
//+
Line(63) = {63, 64};
//+
Line(64) = {64, 67};
//+
Line(65) = {62, 65};
//+
Line(66) = {65, 66};
//+
Line(67) = {66, 68};
//+
Line(68) = {67, 69};
//+
Line(69) = {69, 68};
//+
Curve Loop(2) = {36, 37, 40, 41, 44, 46, 48, 49, 51, 54, 56, 57, 59, 61, 65, 66, 67, -69, -68, -64, -63, -62, -60, -58, -55, -53, -52, -50, -47, -45, -43, -42, -39, -38, -35, -33, -31, -30, -28, -26, -23, -22, -18, -17, -14, -13, -11, -10, -6, -3, -2, -1, 4, 5, 24, 7, 8, 9, 12, 15, 16, 19, 20, 21, 25, 27, 29, 32, 34};
//+
Plane Surface(1) = {2};
//+
out = Extrude {0, 0, 0.5} {Surface{1}; };
//+
// Physical Volume (extruded 3D volume)
Physical Volume("fluid", 100) = {out[1]};


//+
Physical Surface("frontAndBackPlanes", 417) = {416, 1};
//+
Physical Surface("wall_horizental", 418) = {347, 355, 359, 339, 367, 327, 319, 383, 391, 303, 295, 407, 415, 279, 271, 155, 163, 255, 247, 179, 187, 231, 223, 203};
//+
Physical Surface("wall_vertical", 419) = {335, 363, 331, 371, 323, 375, 315, 379, 311, 387, 307, 395, 299, 399, 403, 291, 411, 287, 283, 143, 275, 147, 151, 267, 263, 159, 259, 167, 251, 171, 243, 175, 239, 183, 235, 191, 227, 195, 199, 219, 215, 207};
//+
Physical Surface("outlet", 420) = {211};
//+
Physical Surface("inlet_1", 421) = {343};
//+
Physical Surface("inlet_2", 422) = {351};
//+
