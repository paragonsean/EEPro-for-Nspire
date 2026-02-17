--------------------------
---- FormulaPro 1.42b ----
---- Calculus & Stats   ----
----  LGPL 3 License    ----
--------------------------
----   Jim Bauwens    ----
---- Adrien Bertrand  ----
--------------------------
----  TI-Planet.org   ----
--------------------------

local utf8 = string.uchar

SubNumbers = {185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}
function numberToSub(w, n)
	return w .. utf8(SubNumbers[tonumber(n)])
end

Constants = {}
Constants["pi"]     = {info="Pi"                    , value="pi"   , unit=nil}
Constants["e"]      = {info="Euler's number"        , value="e"    , unit=nil}
Constants[utf8(960)] = Constants["pi"]
