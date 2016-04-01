
# f_pfd_min = 19
# f_pfd_max = 400

# vco_min = 400
# vco_max = 1000

import sys, math

fin = float(sys.argv[1])

# from spartan 6 part 
vcomin = 400.
vcomax = 1000.
pfdmin = 19.
pfdmax = 400.

dmin = int(math.ceil(fin/pfdmax))
dmax = int(math.floor(fin/pfdmin))

mmin = int(math.ceil( vcomin / fin ) * dmin)
mmax = int(math.floor( dmax * vcomax / fin ))

mideal = dmin * vcomax / fin

print "Dmin", dmin, "Dmax", dmax, "Mmin", mmin, "Mmax", mmax, "Mideal", mideal

target = float(sys.argv[2])

mmax /= 2 # because of the 2x clock
mmin /= 2

best = fin * mmin / dmin
print "initial %0.2f *" % fin, mmin, "/",dmin,"=", best
for i in range(mmin,mmax+1,1):
    for j in range(dmin,dmax+1,1): 
         if fin * i * 2 / j > vcomax:
            continue # skip if exceeds vcomax
         for d2 in range(1, 33, 1):
            n=fin * i / j / d2
            if abs(target-n) < abs(target-best):
                best=n
                print "%0.2f *" % fin,i,"/",j,"= %0.2f" % (fin*i/j), " div2=%d" % d2, " result: %0.2f" % best 


