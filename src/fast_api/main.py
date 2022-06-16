import numpy as np
from pymilvus import connections, \
	utility, \
	FieldSchema, \
	CollectionSchema, \
	DataType, \
	Collection
import pymysql

"""
Connect to Servers
"""
# Connectings to Milvus, BERT and Postgresql
connections.connect(host='localhost', port='19537')
conn = pymysql.connect(
	host='localhost',
	user='root',
	port=3306,
	password='123456',
	database='mysql',
	local_infile=True
)
cursor = conn.cursor()

"""
Creating Collection
"""
collection_name = "word_embeddings"
dimension = 300
metric_type = "IP"
index_type = "IVF_FLAT"

if utility.has_collection(collection_name):
	Collection(name=collection_name).drop()

field_1 = FieldSchema(
	name="id",
	dtype=DataType.INT64,
	description="int64",
	is_primary=True,
	auto_id=True
)

field_2 = FieldSchema(
	name="embedding",
	dtype=DataType.FLOAT_VECTOR,
	description="float vector",
	dim=dimension,
	is_primary=False
)

schema = CollectionSchema(
	fields=[field_1, field_2],
	description="collection description"
)

collection = Collection(name=collection_name, schema=schema)

"""
Setting Index
"""
# Information about different indexes: https://milvus.io/docs/index.md
default_index = {
	"index_type": index_type,
	"metric_type": metric_type,
	"params": {"nlist": 200}
}

collection.create_index(field_name="embedding", index_params=default_index)

"""

"""
