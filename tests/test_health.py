from fastapi.testclient import TestClient

from app.config import settings
from app.main import app

client = TestClient(app)


def test_health() -> None:
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_version() -> None:
    response = client.get("/version")

    assert response.status_code == 200

    data = response.json()
    
    assert data["app_name"] == settings.app_name
    assert data["version"] == settings.version
    assert data["environment"] == settings.environment
   
