# base Docker image that we will build on
FROM python:3.9

# setup our image by installing pre-requisites; check the imports in ingest_data.py
RUN pip install pandas sqlalchemy psycopg2 requests tqdm validators pathlib
# setup on the working directory inside the container 
WORKDIR /app

# copy the script to the container 1st name is the source file. 2nd is destination
COPY ingest_data_csv.py ingest_data_csv.py

# define what to do first when the container runs
# in this example, we will just run the script
ENTRYPOINT ["python", "ingest_data_csv.py" ]
