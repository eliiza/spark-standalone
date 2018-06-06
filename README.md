While Spark 2.3 adds support for native k8s, Python and R drivers are still in development.

This docker image, instead, allows the deployment of Spark Standalone in k8s with R support

To run locally:
```
$ docker-compose up
```

And to scale up the workers to 3 nodes
```
$ docker-compose up --scale slave=3
```
