.PHONY: install install-dev test lint format run docker-build docker-run lambda-health

install:
	pip install -r requirements.txt

install-dev:
	pip install -r requirements.txt -r requirements-dev.txt

test:
	pytest -q

lint:
	ruff check app tests
	black --check app tests

format:
	ruff check app tests --fix
	black app tests

run:
	uvicorn app.main:app --reload

docker-build:
	docker build -t fuel-consumption-calculator:local .

docker-run:
	docker run --rm -p 9000:8080 fuel-consumption-calculator:local

lambda-health:
	curl -X POST "http://localhost:9000/2015-03-31/functions/function/invocations" \
		-d '{"version":"2.0","routeKey":"GET /health","rawPath":"/health","headers":{},"requestContext":{"http":{"method":"GET","path":"/health","sourceIp":"127.0.0.1","userAgent":"curl"}},"isBase64Encoded":false}'
