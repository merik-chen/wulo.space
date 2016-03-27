from __future__ import print_function

import sys
from operator import add

try:
    from pyspark import SparkContext
    from pyspark import SparkConf
    print ("Successfully imported Spark Modules")
except ImportError as e:
    print ("Can not import Spark Modules", e)
    sys.exit(-1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: wordcount <file>", file=sys.stderr)
        exit(-1)
    sc = SparkContext(appName="PythonWordCount")
    lines = sc.textFile(sys.argv[1], 2)
    counts = lines.flatMap(lambda x: x.split()) \
                  .map(lambda x: (x, 1)) \
                  .reduceByKey(add)\
                  .map(lambda x: (x[1], x[0]))\
                  .sortByKey(False)
    output = counts.take(5)
    for (word, count) in output:
        print("%i\t%s" % (word, count))

    sc.stop()
