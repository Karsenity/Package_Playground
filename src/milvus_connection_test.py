# 7. drop collection
import time

import numpy as np
from pymilvus import connections, utility, FieldSchema, CollectionSchema, DataType, Collection

fmt = "\n=== {:30} ===\n"


print(fmt.format("start connecting to Milvus"))
connections.connect("default", host="35.227.32.120", port="19530")
print("\nSuccess!")
