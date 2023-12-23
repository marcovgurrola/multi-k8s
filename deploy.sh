docker build -t marcovgurrola/multi-client:latest -t marcovgurrola/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcovgurrola/multi-server:latest -t marcovgurrola/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcovgurrola/multi-worker:latest -t marcovgurrola/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcovgurrola/multi-client:latest
docker push marcovgurrola/multi-server:latest
docker push marcovgurrola/multi-worker:latest

docker push marcovgurrola/multi-client:$SHA
docker push marcovgurrola/multi-server:$SHA
docker push marcovgurrola/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=marcovgurrola/multi-client:$SHA
kubectl set image deployments/server-deployment server=marcovgurrola/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=marcovgurrola/multi-worker:$SHA