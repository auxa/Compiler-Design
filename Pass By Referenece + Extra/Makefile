CSHARPCOMPILER = dmcs

build: Tastier.ATG
	mkdir -p generated
	mono Coco.exe -o generated -namespace Tastier Tastier.ATG
	$(CSHARPCOMPILER) Tastier.cs CodeGen.cs SymTab.cs generated/*.cs -out:tcc.exe

compile: build
	rm -f TastierProject.s
	mono tcc.exe TastierProgram.TAS > Tastier.s
	cat TastierProjectHeader.s Tastier.s TastierProjectFooter.s > TastierProject.s

clean:
	rm -rf generated/
