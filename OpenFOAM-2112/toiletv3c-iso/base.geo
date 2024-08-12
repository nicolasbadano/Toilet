dx = 0.005;

yMin = 0; //-0.195;
ly = 0.195 - yMin;

xMin = -0.22;
lx1 = 0.28 - xMin;
lx2 = 0.47 - 0.28;

zMin = -0.61;
lz1 = -0.005 - zMin;
lz2 = 0.345 + 0.005;

Point(1) = {xMin, yMin, zMin};

Extrude {0, ly, 0} {
  Point{1}; Layers{ly/dx}; Recombine;
}

Extrude {lx1, 0, 0} {
  Line{1}; Layers{lx1/dx}; Recombine;
}

Extrude {lx2, 0, 0} {
  Line{2}; Layers{lx2/dx}; Recombine;
}

Extrude {0, 0, lz1} {
  Surface{5,9}; Layers{lz1/dx}; Recombine;
}

Extrude {0, 0, lz2} {
  Surface{53}; Layers{lz2/dx}; Recombine;
}

Coherence;
Physical Surface("outlet") = {5,9};
Physical Surface("atmosphere1") = {75};
Physical Surface("atmosphere2") = {31};
Physical Surface("symmetry") = {30,52,74};
Physical Volume(135) = {1, 2, 3};
