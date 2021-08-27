docker build -t nattawatsongsom/multi-client:latest -f ./client/Dockerfile ./client
docker build -t nattawatsongsom/multi-server:latest -f ./server/Dockerfile ./server
docker build -t nattawatsongsom/multi-worker:latest -f ./worker/Dockerfile ./worker
docker push nattawatsongsom/multi-client:latest
docker push nattawatsongsom/multi-server:latest
docker push nattawatsongsom/multi-worker:latest
docker push nattawatsongsom/multi-client:$SHA
docker push nattawatsongsom/multi-server:$SHA
docker push nattawatsongsom/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nattawatsongsom/multi-server:$SHA
kubectl set image deployments/client-deployment client=nattawatsongsom/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nattawatsongsom/multi-worker:$SHA