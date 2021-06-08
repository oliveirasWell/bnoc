FROM continuumio/miniconda3
#ARG cmd

WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "bnoc", "/bin/bash", "-c"]

# Demonstrate the environment is activated:

# The code to run when container is started:
COPY . app/


#RUN echo "$cmd"

#ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "mfbn", "$cmd"]
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "bnoc", "python", "app/bnoc/bnoc.py", "-cnf", "app/bnoc/bipartite-time-ncol.json"]