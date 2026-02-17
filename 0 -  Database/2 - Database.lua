
function checkIfExists(table, name)
    for k,v in pairs(table) do
        if (v.name == name) or (v == name) then
            print("Conflict detected when loading Database. Skipping the item.")
            return true
        end
    end
    return false
end

function checkIfFormulaExists(table, formula)
    for k,v in pairs(table) do
        if (v.formula == formula) then
            print("Conflict (formula appearing twice) detected when loading Database. Skipping formula.")
            return true
        end
    end
    return false
end

Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
    if checkIfExists(Categories, name) then
        print("Warning ! This category appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
    Categories[cid].varlink[var] = {unit=unit, info=info }
end

function addSubCat(cid, id, name, info)
    if checkIfExists(Categories[cid].sub, name) then
        print("Warning ! This subcategory appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function aF(cid, sid, formula, variables)
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}
    table.insert(Formulas, fr)
    if not checkIfFormulaExists(Categories[cid].sub[sid].formulas, fr.formula) then
        table.insert(Categories[cid].sub[sid].formulas, fr)
    end
	for variable,_ in pairs(variables) do
		Categories[cid].sub[sid].variables[variable]	= true
	end
end

function U(...)
	local out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

----------------------------------------------
-- Calculus && Statistics -- Formula Database
----------------------------------------------

c_pi = utf8(960)

--------------
-- CALCULUS --
--------------

addCat(1, "Limits and Continuity", "Evaluate limits and analyze continuity")

addCatVar(1, "L", "Limit value", "unitless")
addCatVar(1, "a", "Approach value", "unitless")
addCatVar(1, "n", "Term index", "unitless")
addCatVar(1, "r", "Common ratio", "unitless")

addSubCat(1, 1, "Geometric Series", "")
aF(1, 1, "L=a/(1-r)", U("L","a","r"))
aF(1, 1, "a=L*(1-r)", U("a","L","r"))
aF(1, 1, "r=1-a/L", U("r","a","L"))

addSubCat(1, 2, "Limit Forms", "")
aF(1, 2, "L=(1+1/n)^n", U("L","n"))


addCat(2, "Derivatives", "Differentiation rules and applications")

addCatVar(2, "n", "Exponent / power", "unitless")
addCatVar(2, "k", "Constant", "unitless")
addCatVar(2, "a", "Base of exponential", "unitless")
addCatVar(2, "x", "Variable", "unitless")
addCatVar(2, "f", "Function value", "unitless")
addCatVar(2, "fp", "Derivative value", "unitless")
addCatVar(2, "R", "Radius of curvature", "unitless")
addCatVar(2, "y", "y value", "unitless")
addCatVar(2, "yp", "First derivative", "unitless")
addCatVar(2, "ypp", "Second derivative", "unitless")

addSubCat(2, 1, "Power Rule", "")
aF(2, 1, "fp=n*k*x^(n-1)", U("fp","n","k","x"))
aF(2, 1, "k=fp/(n*x^(n-1))", U("k","fp","n","x"))
aF(2, 1, "x=(fp/(n*k))^(1/(n-1))", U("x","fp","n","k"))

addSubCat(2, 2, "Exponential Derivatives", "")
aF(2, 2, "fp=k*a^x*ln(a)", U("fp","k","a","x"))
aF(2, 2, "fp=k*exp(x)", U("fp","k","x"))

addSubCat(2, 3, "Curvature", "")
aF(2, 3, "R=abs((1+yp^2)^(3/2)/ypp)", U("R","yp","ypp"))
aF(2, 3, "ypp=abs((1+yp^2)^(3/2)/R)", U("ypp","yp","R"))


addCat(3, "Integrals", "Integration formulas and applications")

addCatVar(3, "a", "Lower limit", "unitless")
addCatVar(3, "b", "Upper limit", "unitless")
addCatVar(3, "n", "Exponent", "unitless")
addCatVar(3, "I", "Integral value", "unitless")
addCatVar(3, "k", "Constant", "unitless")

addSubCat(3, 1, "Power Rule Integration", "")
aF(3, 1, "I=k*(b^(n+1)-a^(n+1))/(n+1)", U("I","k","a","b","n"))
aF(3, 1, "k=I*(n+1)/(b^(n+1)-a^(n+1))", U("k","I","a","b","n"))

addSubCat(3, 2, "Definite Integral Bounds", "")
aF(3, 2, "I=(b^2-a^2)/2", U("I","a","b"))
aF(3, 2, "b=sqrt(2*I+a^2)", U("b","I","a"))
aF(3, 2, "a=sqrt(b^2-2*I)", U("a","b","I"))

addSubCat(3, 3, "Exponential Integral", "")
aF(3, 3, "I=k*(exp(b)-exp(a))", U("I","k","a","b"))
aF(3, 3, "k=I/(exp(b)-exp(a))", U("k","I","a","b"))


addCat(4, "Applications of Calculus", "Related rates, optimization, arc length")

addCatVar(4, "V", "Volume", "unitless")
addCatVar(4, "r", "Radius", "unitless")
addCatVar(4, "h", "Height", "unitless")
addCatVar(4, "S", "Surface area", "unitless")
addCatVar(4, "L", "Arc length", "unitless")
addCatVar(4, "A", "Area", "unitless")
addCatVar(4, "x", "Dimension", "unitless")
addCatVar(4, "dr", "Rate of change of r", "unitless")
addCatVar(4, "dV", "Rate of change of V", "unitless")

addSubCat(4, 1, "Sphere", "")
aF(4, 1, "V=4/3*"..c_pi.."*r^3", U("V","r"))
aF(4, 1, "r=(3*V/(4*"..c_pi.."))^(1/3)", U("r","V"))
aF(4, 1, "S=4*"..c_pi.."*r^2", U("S","r"))
aF(4, 1, "r=sqrt(S/(4*"..c_pi.."))", U("r","S"))

addSubCat(4, 2, "Cylinder", "")
aF(4, 2, "V="..c_pi.."*r^2*h", U("V","r","h"))
aF(4, 2, "r=sqrt(V/("..c_pi.."*h))", U("r","V","h"))
aF(4, 2, "h=V/("..c_pi.."*r^2)", U("h","V","r"))
aF(4, 2, "S=2*"..c_pi.."*r^2+2*"..c_pi.."*r*h", U("S","r","h"))

addSubCat(4, 3, "Cone", "")
aF(4, 3, "V="..c_pi.."*r^2*h/3", U("V","r","h"))
aF(4, 3, "h=3*V/("..c_pi.."*r^2)", U("h","V","r"))
aF(4, 3, "r=sqrt(3*V/("..c_pi.."*h))", U("r","V","h"))

addSubCat(4, 4, "Related Rates (Sphere)", "")
aF(4, 4, "dV=4*"..c_pi.."*r^2*dr", U("dV","r","dr"))
aF(4, 4, "dr=dV/(4*"..c_pi.."*r^2)", U("dr","dV","r"))
aF(4, 4, "r=sqrt(dV/(4*"..c_pi.."*dr))", U("r","dV","dr"))


--------------
-- STATISTICS --
--------------

addCat(5, "Descriptive Statistics", "Mean, variance, standard deviation")

addCatVar(5, "xbar", "Sample mean", "unitless")
addCatVar(5, "mu", "Population mean", "unitless")
addCatVar(5, "n", "Sample size", "unitless")
addCatVar(5, "sumx", "Sum of values", "unitless")
addCatVar(5, "s2", "Sample variance", "unitless")
addCatVar(5, "s", "Sample std deviation", "unitless")
addCatVar(5, "sigma2", "Population variance", "unitless")
addCatVar(5, "sigma", "Population std deviation", "unitless")

addSubCat(5, 1, "Mean", "")
aF(5, 1, "xbar=sumx/n", U("xbar","sumx","n"))
aF(5, 1, "sumx=xbar*n", U("sumx","xbar","n"))
aF(5, 1, "n=sumx/xbar", U("n","sumx","xbar"))

addSubCat(5, 2, "Variance and Std Dev", "")
aF(5, 2, "s=sqrt(s2)", U("s","s2"))
aF(5, 2, "s2=s^2", U("s2","s"))
aF(5, 2, "sigma=sqrt(sigma2)", U("sigma","sigma2"))
aF(5, 2, "sigma2=sigma^2", U("sigma2","sigma"))


addCat(6, "Probability", "Basic probability rules")

addCatVar(6, "PA", "P(A)", "unitless")
addCatVar(6, "PB", "P(B)", "unitless")
addCatVar(6, "PAandB", "P(A and B)", "unitless")
addCatVar(6, "PAorB", "P(A or B)", "unitless")
addCatVar(6, "PAgB", "P(A|B)", "unitless")
addCatVar(6, "PBgA", "P(B|A)", "unitless")

addSubCat(6, 1, "Addition Rule", "")
aF(6, 1, "PAorB=PA+PB-PAandB", U("PAorB","PA","PB","PAandB"))
aF(6, 1, "PAandB=PA+PB-PAorB", U("PAandB","PA","PB","PAorB"))
aF(6, 1, "PA=PAorB-PB+PAandB", U("PA","PAorB","PB","PAandB"))

addSubCat(6, 2, "Conditional Probability", "")
aF(6, 2, "PAgB=PAandB/PB", U("PAgB","PAandB","PB"))
aF(6, 2, "PAandB=PAgB*PB", U("PAandB","PAgB","PB"))
aF(6, 2, "PB=PAandB/PAgB", U("PB","PAandB","PAgB"))
aF(6, 2, "PAandB=PBgA*PA", U("PAandB","PBgA","PA"))

addSubCat(6, 3, "Bayes' Theorem", "")
aF(6, 3, "PBgA=PAgB*PB/PA", U("PBgA","PAgB","PB","PA"))
aF(6, 3, "PAgB=PBgA*PA/PB", U("PAgB","PBgA","PA","PB"))


addCat(7, "Distributions", "Normal, binomial, and sampling distributions")

addCatVar(7, "z", "Z-score", "unitless")
addCatVar(7, "x", "Value", "unitless")
addCatVar(7, "mu", "Population mean", "unitless")
addCatVar(7, "sigma", "Population std dev", "unitless")
addCatVar(7, "xbar", "Sample mean", "unitless")
addCatVar(7, "n", "Sample size", "unitless")
addCatVar(7, "t", "T-score", "unitless")
addCatVar(7, "s", "Sample std dev", "unitless")
addCatVar(7, "p", "Probability / proportion", "unitless")
addCatVar(7, "q", "1-p", "unitless")
addCatVar(7, "np", "Binomial mean", "unitless")
addCatVar(7, "npq", "Binomial variance", "unitless")

addSubCat(7, 1, "Z-Score (Raw)", "")
aF(7, 1, "z=(x-mu)/sigma", U("z","x","mu","sigma"))
aF(7, 1, "x=mu+z*sigma", U("x","mu","z","sigma"))
aF(7, 1, "mu=x-z*sigma", U("mu","x","z","sigma"))
aF(7, 1, "sigma=(x-mu)/z", U("sigma","x","mu","z"))

addSubCat(7, 2, "Z-Score (Sample Mean)", "")
aF(7, 2, "z=(xbar-mu)/(sigma/sqrt(n))", U("z","xbar","mu","sigma","n"))
aF(7, 2, "xbar=mu+z*sigma/sqrt(n)", U("xbar","mu","z","sigma","n"))
aF(7, 2, "n=(z*sigma/(xbar-mu))^2", U("n","z","sigma","xbar","mu"))

addSubCat(7, 3, "T-Score", "")
aF(7, 3, "t=(xbar-mu)/(s/sqrt(n))", U("t","xbar","mu","s","n"))
aF(7, 3, "xbar=mu+t*s/sqrt(n)", U("xbar","mu","t","s","n"))
aF(7, 3, "s=(xbar-mu)*sqrt(n)/t", U("s","xbar","mu","n","t"))

addSubCat(7, 4, "Binomial Distribution", "")
aF(7, 4, "np=n*p", U("np","n","p"))
aF(7, 4, "npq=n*p*q", U("npq","n","p","q"))
aF(7, 4, "q=1-p", U("q","p"))
aF(7, 4, "p=1-q", U("p","q"))


addCat(8, "Confidence Intervals", "Margin of error and interval bounds")

addCatVar(8, "xbar", "Sample mean", "unitless")
addCatVar(8, "E", "Margin of error", "unitless")
addCatVar(8, "z", "Critical z-value", "unitless")
addCatVar(8, "sigma", "Population std dev", "unitless")
addCatVar(8, "n", "Sample size", "unitless")
addCatVar(8, "s", "Sample std dev", "unitless")
addCatVar(8, "t", "Critical t-value", "unitless")
addCatVar(8, "L", "Lower bound", "unitless")
addCatVar(8, "U", "Upper bound", "unitless")
addCatVar(8, "phat", "Sample proportion", "unitless")

addSubCat(8, 1, "Mean (σ known)", "")
aF(8, 1, "E=z*sigma/sqrt(n)", U("E","z","sigma","n"))
aF(8, 1, "n=(z*sigma/E)^2", U("n","z","sigma","E"))
aF(8, 1, "z=E*sqrt(n)/sigma", U("z","E","n","sigma"))
aF(8, 1, "L=xbar-E", U("L","xbar","E"))
aF(8, 1, "U=xbar+E", U("U","xbar","E"))
aF(8, 1, "xbar=(L+U)/2", U("xbar","L","U"))

addSubCat(8, 2, "Mean (σ unknown)", "")
aF(8, 2, "E=t*s/sqrt(n)", U("E","t","s","n"))
aF(8, 2, "n=(t*s/E)^2", U("n","t","s","E"))

addSubCat(8, 3, "Proportion", "")
aF(8, 3, "E=z*sqrt(phat*(1-phat)/n)", U("E","z","phat","n"))
aF(8, 3, "n=phat*(1-phat)*(z/E)^2", U("n","phat","z","E"))


addCat(9, "Hypothesis Tests", "Test statistics and significance")

addCatVar(9, "z", "Z test statistic", "unitless")
addCatVar(9, "t", "T test statistic", "unitless")
addCatVar(9, "xbar", "Sample mean", "unitless")
addCatVar(9, "mu0", "Hypothesized mean", "unitless")
addCatVar(9, "sigma", "Population std dev", "unitless")
addCatVar(9, "s", "Sample std dev", "unitless")
addCatVar(9, "n", "Sample size", "unitless")
addCatVar(9, "phat", "Sample proportion", "unitless")
addCatVar(9, "p0", "Hypothesized proportion", "unitless")

addSubCat(9, 1, "Z-Test for Mean", "")
aF(9, 1, "z=(xbar-mu0)/(sigma/sqrt(n))", U("z","xbar","mu0","sigma","n"))
aF(9, 1, "xbar=mu0+z*sigma/sqrt(n)", U("xbar","mu0","z","sigma","n"))

addSubCat(9, 2, "T-Test for Mean", "")
aF(9, 2, "t=(xbar-mu0)/(s/sqrt(n))", U("t","xbar","mu0","s","n"))
aF(9, 2, "xbar=mu0+t*s/sqrt(n)", U("xbar","mu0","t","s","n"))

addSubCat(9, 3, "Z-Test for Proportion", "")
aF(9, 3, "z=(phat-p0)/sqrt(p0*(1-p0)/n)", U("z","phat","p0","n"))
aF(9, 3, "phat=p0+z*sqrt(p0*(1-p0)/n)", U("phat","p0","z","n"))


addCat(10, "Regression", "Linear regression formulas")

addCatVar(10, "b0", "y-intercept", "unitless")
addCatVar(10, "b1", "Slope", "unitless")
addCatVar(10, "xbar", "Mean of x", "unitless")
addCatVar(10, "ybar", "Mean of y", "unitless")
addCatVar(10, "r", "Correlation coefficient", "unitless")
addCatVar(10, "sx", "Std dev of x", "unitless")
addCatVar(10, "sy", "Std dev of y", "unitless")

addSubCat(10, 1, "Regression Line", "")
aF(10, 1, "b0=ybar-b1*xbar", U("b0","ybar","b1","xbar"))
aF(10, 1, "b1=(ybar-b0)/xbar", U("b1","ybar","b0","xbar"))
aF(10, 1, "ybar=b0+b1*xbar", U("ybar","b0","b1","xbar"))
aF(10, 1, "b1=r*sy/sx", U("b1","r","sy","sx"))
aF(10, 1, "r=b1*sx/sy", U("r","b1","sx","sy"))
