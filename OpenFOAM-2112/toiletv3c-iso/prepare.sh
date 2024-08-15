#! /bin/bash
. ~/corridas/OpenFOAM/OpenFOAM-v2112/etc/bashrc

rm -r constant/polyMesh
rm -r 0
rm -r processor*
rm -r postProcessing

gmsh -3 base.geo
gmshToFoam base.msh

surfaceFeatureExtract

# Run snappyHexMesh in parallel.
cp system/decomposeParDict.scotch system/decomposeParDict
decomposePar
cp system/decomposeParDict.ptscotch system/decomposeParDict
mpirun -np 24 snappyHexMesh -parallel -overwrite
reconstructParMesh -constant
renumberMesh -overwrite
cp system/decomposeParDict.scotch system/decomposeParDict
rm -r processor*
cp system/decomposeParDict.scotch system/decomposeParDict

checkMesh
cp -r 0.model 0
setFields
decomposePar
