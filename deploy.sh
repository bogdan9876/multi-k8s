docker build -t etenity/multi-client:latest -t etenity/multi-client:$SHA -f client/Dockerfile ./client
docker build -t etenity/multi-server -t etenity/multi-server:$SHA -f server/Dockerfile ./server
docker build -t etenity/multi-worker -t etenity/multi-worker:$SHA -f worker/Dockerfile ./worker
docker push etenity/multi-client:latest
docker push etenity/multi-server:latest
docker push etenity/multi-worker:latest
docker push etenity/multi-client:$SHA
docker push etenity/multi-server:$SHA
docker push etenity/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=etenity/multi-server:$SHA
kubectl set image deployments/client-deployment client=etenity/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=etenity/multi-worker:$SHA