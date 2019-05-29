docker build -t neogeowild/multi-client:latest -t neogeowild/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neogeowild/multi-server:latest -t neogeowild/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neogeowild/multi-worker:latest -t neogeowild/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push neogeowild/multi-client:latest
docker push neogeowild/multi-server:latest
docker push neogeowild/multi-worker:latest

docker push neogeowild/multi-client:$SHA
docker push neogeowild/multi-server:$SHA
docker push neogeowild/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=neogeowild/multi-server:$SHA
kubectl set image deployments/client-deployment client=neogeowild/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=neogeowild/multi-worker:$SHA