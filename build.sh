#!/bin/sh

# Jim and Adriweb

echo "Building Calc & Stats for TI-Nspire v1.42b..."

echo "Building the database"
cd 0\ -\ \ Database
./build.sh

#cd ..
#cd 1\ -\ \ Analysis\ Part
#./build.sh

echo "Building the Calc & Stats core"
cd ..
cd 2\ -\ \ FormulaPro
./build.sh

echo "Building Reference"
cd ..
cd 3\ -\ \ Reference\ Part
./build.sh

echo "Building the libraries"
cd ..
cd Global\ Libraries
./build.sh

cd ..

echo "Creating the whole thing..."
cat Database.big.lua lib.big.lua FormulaPro.big.lua Reference.big.lua main.lua > CalcStats.big.lua
mv CalcStats.big.lua FormulaPro_fullcode.lua
luna FormulaPro_fullcode.lua CalcStats.tns

echo "Done building"

echo "Cleaning up"
rm *.big.lua

echo "Done. Enjoy !"
