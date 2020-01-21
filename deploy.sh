docker build -t kerv102/multi-client:latest -t kerv102/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kerv012/multi-server:latest  -t kerv102/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kerv012/multi-worker:latest  -t kerv102/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kerv102/multi-client:latest
docker push kerv102/multi-server:latest
docker push kerv102/multi-worker:latest
docker push kerv102/multi-client:$SHA
docker push kerv102/multi-server:$SHA
docker push kerv102/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kerv102/multi-server:$SHA
kubectl set image deployments/client-deployment client=kerv102/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kerv102/multi-worker:$SHA