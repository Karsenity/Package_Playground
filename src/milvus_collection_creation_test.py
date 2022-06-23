# 7. drop collection
import time

import numpy as np
from pymilvus import connections, utility, FieldSchema, CollectionSchema, DataType, Collection

fmt = "\n=== {:30} ===\n"
num_entities = 3
dim = 1024

###################################################################
# 1. Connect to the server
###################################################################
print(fmt.format("start connecting to Milvus"))
connections.connect("default", host="35.227.32.120", port="19530")
print("\nSuccess!")

###################################################################
# 2. Create the Schema for pokemon cards
###################################################################
print("\nCreating Collection...")
fields = [
    FieldSchema(name="pk", dtype=DataType.INT64, is_primary=True, auto_id=False),
    FieldSchema(name="embeddings", dtype=DataType.FLOAT_VECTOR, dim=dim)
]
schema = CollectionSchema(fields,
                          description="Test Collection similar to what Pokecards will have")
collection = Collection(
    name="pokemon_cards",
    schema=schema,
    consistency_level="Strong"
)

###################################################################
# 3. Insert dummy data into the collection
###################################################################
print("Inserting data into Milvus...")
import numpy as np
entities = [
    [i for i in range(num_entities)],
    np.random.rand(num_entities, 1024).tolist()
]

insert_result = collection.insert(entities)
print(f"Number of entities in Milvus: {collection.num_entities}")  # check the num_entites

###################################################################
# 4. Query Example
###################################################################
print("\n Querying closest 3 vectors to a random one...")

search_vector = [np.random.rand(1024).tolist()]
search_params = {
    "metric_type": "l2",
    "params": {"nprobe": 10},
}

collection.load()

result = collection.search(
    search_vector,
    "embeddings",
    search_params,
    limit=3,
    output_fields=["pk"]
)
print(f"Results: {result}")