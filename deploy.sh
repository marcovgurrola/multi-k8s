docker build -t marcovgurrola/multi-client-k8s:latest -t marcovgurrola/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t marcovgurrola/multi-server-k8s:latest -t marcovgurrola/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t marcovgurrola/multi-worker-k8s:latest -t marcovgurrola/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push marcovgurrola/multi-client-k8s:latest
docker push marcovgurrola/multi-server-k8s:latest
docker push marcovgurrola/multi-worker-k8s:latest

docker push marcovgurrola/multi-client-k8s:$SHA
docker push marcovgurrola/multi-server-k8s:$SHA
docker push marcovgurrola/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=marcovgurrola/multi-client-k8s:$SHA
kubectl set image deployments/server-deployment server=marcovgurrola/multi-server-k8s:$SHA
kubectl set image deployments/worker-deployment worker=marcovgurrola/multi-worker-k8s:$SHA