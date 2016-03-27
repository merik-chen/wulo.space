import sys

# Append pyspark  to Python Path
# sys.path.append("/opt/local/var/spark/python")

try:
    from pyspark import SparkContext
    from pyspark import SparkConf
    print ("Successfully imported Spark Modules")
except ImportError as e:
    print ("Can not import Spark Modules", e)
    sys.exit(1)
