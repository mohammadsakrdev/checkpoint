docker build -t stephngrider/multi-client:latest -t stephngrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephngrider/multi-worker:latest -t stephngrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t stephngrider/multi-server:latest -t stephngrider/multi-server:$SHA -f ./server/Dockerfile ./server

docker push stephngrider/multi-client:latest
docker push stephngrider/multi-server:latest
docker push stephngrider/multi-worker:latest

docker push stephngrider/multi-client:$SHA
docker push stephngrider/multi-server:$SHA
docker push stephngrider/multi-worker:$SHA

kubectl -f apply k8s
kubectl set image deployments/client-deployment client=stephngrider/multi-client:$SHA
kubectl set image deployments/server-deployment server=stephngrider/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stephngrider/multi-worker:$SHA