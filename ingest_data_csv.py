# import 
import urllib.request
import math
import requests
from tqdm import tqdm
import validators
from time import time
import pandas as pd
from sqlalchemy import create_engine
import psycopg2
import argparse
print('Setup Complete')
print('Running ingest_data_csv.py')

    
def main(params):
    
    # parameters
    user = params.user
    password = params.password
    host  = params.host
    port = params.port
    db_name = params.db_name
    table_name = params.table_name
    source_url = params.source_url

    # adding progress bar
    print('Downloading...')
    response = requests.get(source_url, stream=True)
    total_size = int(response.headers.get("content-length", 0))
    block_size = 1024  #1 Kibibyte

    filename = source_url.split("/")[-1]
    with open(filename, "wb") as f:
        for data in tqdm(response.iter_content(block_size), total=math.ceil(total_size//block_size), unit='KB', unit_scale=True):
            f.write(data)
    
    print('Download Complete, reading csv file...')
    # download from url then save as parquet on the current working directory (cwd)
    csv_name, _ = urllib.request.urlretrieve(source_url, filename="output.csv")
    
    # read csv
    df = pd.read_csv(csv_name, compression='gzip')
    
    # create an engine
    engine = create_engine(f'postgresql://{user}:{password}@{host}:5432/{db_name}')
    
    # convert to sql (this will run for 12mins)
    print('This will take a couple of mins, you can grab a cup of coffee or tea')
    print('.....')
    print('Converting Dataframe to SQL')
    t_start = time()
    df.to_sql(name=table_name, con=engine, if_exists='replace', index=False)
    t_end = time()
    print(f'Total time elapsed: {(t_end - t_start) / 60:.0f} minutes')
    print(f'Number of rows migrated to table: ({table_name}): {df.shape[0]}')

#run main
if __name__ == '__main__':
    # this will take the user, password, host, port, db_name, table_name, and source_url
    parser = argparse.ArgumentParser(description='Ingest parquet data to Postgres')

    parser.add_argument('--user', help='postgres username')
    parser.add_argument('--password', help='postgres password')
    parser.add_argument('--host', help='postgres host', default='localhost')
    parser.add_argument('--port', type=int, help='postgres port', default=5432)
    parser.add_argument('--db_name', type=str, help='postgres database name')
    parser.add_argument('--table_name', type=str, help='postgres table name where we will write the results')
    parser.add_argument('--source_url', type=str, help='postgres url source')

    args = parser.parse_args()

    main(args)
