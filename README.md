# wordpress-mariadb-all-in-one

```
docker build . -t wp
docker rm -f wp
docker run -d --name wp wp
docker logs wp
docker exec -ti wp bash
```


