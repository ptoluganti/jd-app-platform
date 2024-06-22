
.PHONY: run-csharp-svc
run-csharp-svc:
	docker compose -f ./backend/csharp-service/docker-compose.yml up --build 

.PHONY: build-csharp-svc
build-csharp-svc:
	docker build -t ptoluganti/csharp-service -f ./backend/csharp-service/Dockerfile ./backend/csharp-service

.PHONY: push-csharp-svc
push-csharp-svc: build-csharp-svc
	docker push ptoluganti/csharp-service:latest


.PHONY: run-go-svc
run-go-svc:
	docker compose -f ./backend/go-service/docker-compose.yml up --build 
.PHONY: build-go-svc
build-go-svc:
	docker build -t ptoluganti/go-service -f ./backend/go-service/Dockerfile ./backend/go-service

.PHONY: push-go-svc
push-go-svc: build-go-svc
	docker push ptoluganti/go-service:latest