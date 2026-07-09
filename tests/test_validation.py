import pytest
from fastapi.testclient import TestClient

from app.calculator import calculate_consumption, calculate_cost
from app.main import app

client = TestClient(app)


@pytest.mark.parametrize(
    "payload",
    [
        {"distance_km": -100, "fuel_used_liters": 20},
        {"distance_km": 0, "fuel_used_liters": 20},
        {"distance_km": 100, "fuel_used_liters": 0},
        {"distance_km": 100, "fuel_used_liters": -2},
        {"distance_km": 100, "fuel_used_liters": 7, "fuel_price": 0},
    ],
)
def test_endpoint_validation(payload: dict[str, float]) -> None:
    response = client.post("/kalkulatorspalania", json=payload)

    assert response.status_code == 422


def test_invalid_consumption_function() -> None:
    with pytest.raises(ValueError):
        calculate_consumption(distance_km=0, fuel_used_liters=10)


def test_invalid_cost_function() -> None:
    with pytest.raises(ValueError):
        calculate_cost(fuel_used_liters=10, fuel_price=0)
