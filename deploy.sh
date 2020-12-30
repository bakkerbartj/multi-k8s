docker build -t d0ckd0ck/multi-client:latest -t d0ckd0ck/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t d0ckd0ck/multi-server:latest -t d0ckd0ck/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t d0ckd0ck/multi-worker:latest -t d0ckd0ck/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push d0ckd0ck/multi-client:latest
docker push d0ckd0ck/multi-server:latest
docker push d0ckd0ck/multi-worker:latest

docker push d0ckd0ck/multi-client:$SHA
docker push d0ckd0ck/multi-server:$SHA
docker push d0ckd0ck/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=d0ckd0ck/multi-server:$SHA
kubectl set image deployments/client-deployment client=d0ckd0ck/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=d0ckd0ck/multi-worker:$SHA