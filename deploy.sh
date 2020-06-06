docker build -t marbor1/multi-client:latest marbor1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marbor1/multi-server:latest marbor1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marbor1/multi-worker:latest marbor1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push marbor1/multi-client:latest
docker push marbor1/multi-client:latest
docker push marbor1/multi-server:latest

docker push marbor1/multi-server:$SHA
docker push marbor1/multi-worker:$SHA
docker push marbor1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marbor1/multi-server:$SHA
kubectl set image deployments/client-deployment client=marbor1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marbor1/multi-worker:$SHA
