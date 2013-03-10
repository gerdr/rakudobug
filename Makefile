RM = rm -f
PERL6 = perl6

PM = lib/PASM/Backend/AST.pm lib/PASM/Backend/GNUC.pm lib/PASM/Backends.pm lib/PASM/Grammar.pm
PIR = lib/PASM/Backend/AST.pir lib/PASM/Backend/GNUC.pir lib/PASM/Backends.pir lib/PASM/Grammar.pir

.SUFFIXES: .pm .pir

build: $(PIR)

clean:
	$(RM) $(PIR)

pmtest: clean
	$(PERL6) test.pl

pirtest: build
	$(PERL6) test.pl

.pm.pir:
	$(PERL6) -Ilib --target=pir --output=$*.pir $*.pm

lib/PASM/Backend/AST.pir: lib/PASM/Grammar.pir
lib/PASM/Backend/GNUC.pir: lib/PASM/Grammar.pir
lib/PASM/Backends.pir: lib/PASM/Backend/AST.pir lib/PASM/Backend/GNUC.pir
