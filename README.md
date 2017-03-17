# minio-dcos

This is a sample project for running a 4 node Minio cluster on DC/OS via Marathon.

It uses
 * Overlay networking
 * Local persistent volumes

It's curently not exposing anything via marathon-lb to the outside world.

## Startup log

If you start the application, you should see something like this in the tasks logs:

```
Endpoint: minio-dcos.marathon.containerip.dcos.thisdcos.directory
Endpoint IPs are:
9.0.1.130
9.0.2.130
9.0.2.131
9.0.2.132
Got matching endpoints compared to Marathon instances
The following command will be run to start Minio:
minio server  http://9.0.1.130/export http://9.0.2.130/export http://9.0.2.131/export http://9.0.2.132/export
Created minio configuration file successfully at /root/.minio
Initializing data volume for first time. Waiting for other servers to come online (elapsed 17s)
[2K
[A
Initializing data volume.
[01/04] http://9.0.1.130:9000/export - 37 GiB online
[02/04] http://9.0.2.130:9000/export - 37 GiB online
[03/04] http://9.0.2.131:9000/export - 37 GiB online
[04/04] http://9.0.2.132:9000/export - 37 GiB online
Endpoint:  http://9.0.2.132:9000  http://127.0.0.1:9000
AccessKey: miniotest 
SecretKey: secret123 
Region:    us-east-1
SQS ARNs:  <none>
Browser Access:
   http://9.0.2.132:9000  http://127.0.0.1:9000
Command-line Access: https://docs.minio.io/docs/minio-client-quickstart-guide
   $ mc config host add myminio http://9.0.2.132:9000 miniotest secret123
Object API (Amazon S3 compatible):
   Go:         https://docs.minio.io/docs/golang-client-quickstart-guide
   Java:       https://docs.minio.io/docs/java-client-quickstart-guide
   Python:     https://docs.minio.io/docs/python-client-quickstart-guide
   JavaScript: https://docs.minio.io/docs/javascript-client-quickstart-guide
Drive Capacity: 70 GiB Free, 74 GiB Total
Status:         4 Online, 0 Offline. We can withstand [2] more drive failure(s).
```