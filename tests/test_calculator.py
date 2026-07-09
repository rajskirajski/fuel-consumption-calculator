from fastapi.testclient import TestClient

from app.calculator import calculate_consumption, calculate_cost
from app.main import app

client = TestClient(app)


def test_calculate_consumption_function() -> None:
    assert calculate_consumption(distance_km=500, fuel_used_liters=40) == 8.0


def test_calculate_consumption_rounding() -> None:
    assert calculate_consumption(distance_km=333, fuel_used_liters=25) == 7.51


def test_calculate_cost_function() -> None:
    assert calculate_cost(fuel_used_liters=7, fuel_price=6.5) == 45.5


def test_consumption_endpoint_without_cost() -> None:
    response = client.post(
        "/kalkulatorspalania",
        json={
            "distance_km": 500,
            "fuel_used_liters": 40,
        },
    )

    assert response.status_code == 200
    assert response.json() == {
        "fuel_consumption": 8.0,
        "total_cost": None,
    }


def test_consumption_endpoint_with_cost() -> None:
    response = client.post(
        "/kalkulatorspalania",
        json={
            "distance_km": 100,
            "fuel_used_liters": 7,
            "fuel_price": 6.5,
        },
    )

    assert response.status_code == 200
    assert response.json() == {
        "fuel_consumption": 7.0,
        "total_cost": 45.5,
    }
