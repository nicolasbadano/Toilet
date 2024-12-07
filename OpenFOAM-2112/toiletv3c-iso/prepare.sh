#!/bin/bash



#rm -r constant/polyMesh
rm -r 0
rm -r postProcessing



gmsh -3 base.geo
gmshToFoam base.msh

#blockMesh

surfaceFeatureExtract

# Run snappyHexMesh in parallel.
N_PROCS=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
foamDictionary -entry numberOfSubdomains system/decomposeParDict -set $N_PROCS

# Set application name

decomposePar -force
foamJob -parallel -screen snappyHexMesh -parallel -overwrite
reconstructParMesh -constant
renumberMesh -overwrite

checkMesh
cp -r 0.model 0
setFields

decomposePar -force
foamJob -parallel -screen interIsoFoam
reconstructPar
