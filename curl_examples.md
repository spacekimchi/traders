curl localhost:8000/health_check

curl -X POST localhost:8000/users \
	-H 'content-type: application/json' \
	-d '{"username": "usa1", "email": "email1.com"}'
