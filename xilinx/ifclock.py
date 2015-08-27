import sys

clkdep=[dep for dep in sys.argv[1:] if dep.startswith('UXN1330_IFCLK_FREQ')]

if len(clkdep):
    sys.stdout.write ( clkdep[0].split('=')[1] )
else:
    sys.stdout.write ( "50.4" )
sys.stdout.flush()

