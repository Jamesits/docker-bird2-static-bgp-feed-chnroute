## Usage

```shell
docker build . --tag bird
docker run -it -e LOCAL_AS=65001 -e NEIGHBOR_AS=65001 -e NEIGHBOR_IPV4=192.168.1.1 bird
```

## Credit

IP list from https://www.countryipblocks.net/acl.php .
