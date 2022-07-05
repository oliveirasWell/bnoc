FROM continuumio/miniconda3
#ARG cmd

COPY environment.yml .

RUN conda env create -f environment.yml

COPY . app/
WORKDIR /app

SHELL ["conda", "run", "-n", "bnoc", "/bin/bash", "-c"]

#ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "mfbn", "$cmd"]
#ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "bnoc", "python", "app/bnoc/bnoc.py", "-cnf", "app/bnoc/bipartite-time-ncol.json"]