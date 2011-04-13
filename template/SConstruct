import os
env = Environment(ENV=os.environ)

fn = "YourName-thesis"
chapters = Glob("Chapter-*/Chapter-*.tex") + Glob("Appendix-*/Appendix-*.tex")

print chapters

pdfOutput = env.PDF(target=fn+'.pdf',source=fn+'.tex')
Depends(pdfOutput,[fn+'.tex', fn+'.bib', 'ncsuthesis.cls'] + chapters)
