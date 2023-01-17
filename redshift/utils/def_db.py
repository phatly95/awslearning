#!/usr/bin/env python
# coding: utf-8

# In[77]:


import pandas as pd
import psycopg2
from config import db_details as db
from sqlalchemy import create_engine
from sqlalchemy import text


# In[85]:


engine_string = "postgresql+psycopg2://%s:%s@%s:%d/%s" % (db.redshift_user, db.redshift_pass, db.redshift_endpoint, db.port, db.dbname)

engine = create_engine(engine_string)


def execute_query(query:str) :
    conn = psycopg2.connect(host=db.redshift_endpoint, user=db.redshift_user, password=db.redshift_pass, dbname=db.dbname, port=db.port)
    cur = conn.cursor()
    cur.execute(query)  
    cur.close()
    conn.commit()   
    conn.close()
    return

def create_ftot(df, table_name : str, schema : str) :
    return df.to_sql(table_name, con = engine, schema=schema, if_exists='Replace',index=False)

def load_fromcvs(file_name:str, table_name:str, schema:str):
    df = pd.read_csv(file_name)
    return create_ftot(df, table_name, schema)

