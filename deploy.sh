docker build -t agentsimon/multi-client:latest -t agentsimon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t agentsimon/multi-server:latest -t agentsimon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t agentsimon/multi-worker:latest -t agentsimon/multi-workert:$SHA -f ./worker/Dockerfile ./worker

docker push agentsimon/multi-client:latest
docker push agentsimon/multi-server:latest
docker push agentsimon/multi-worker:latest
docker push agentsimon/multi-client:$SHA
docker push agentsimon/multi-server:$SHA
docker push agentsimon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=agentsimon/multi-server:$SHA
kubectl set image deployments/client-deployment client=agentsimon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=agentsimon/multi-worker:$SHA
