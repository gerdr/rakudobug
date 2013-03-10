RM = rm -f
PERL6 = perl6
PARROT = parrot

PM = lib/PASM/Backend/AST.pm lib/PASM/Backend/GNUC.pm lib/PASM/Backends.pm lib/PASM/Grammar.pm
PIR = lib/PASM/Backend/AST.pir lib/PASM/Backend/GNUC.pir lib/PASM/Backends.pir lib/PASM/Grammar.pir
PBC = lib/PASM/Backend/AST.pbc lib/PASM/Backend/GNUC.pbc lib/PASM/Backends.pbc lib/PASM/Grammar.pbc

.SUFFIXES: .pm .pbc

build: $(PBC)

clean:
	$(RM) $(PIR) $(PBC)

pmtest: clean
	$(PERL6) test.pl

pbctest: build
	$(PERL6) test.pl

.pm.pbc:
	$(PERL6) -Ilib --target=pir --output=$*.pir $*.pm
	$(PARROT) -o $*.pbc $*.pir

lib/PASM/Backend/AST.pbc: lib/PASM/Grammar.pbc
lib/PASM/Backend/GNUC.pbc: lib/PASM/Grammar.pbc
lib/PASM/Backends.pbc: lib/PASM/Backend/AST.pbc lib/PASM/Backend/GNUC.pbc
