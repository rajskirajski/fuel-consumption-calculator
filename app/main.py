from fastapi import FastAPI, HTTPException
from mangum import Mangum

from app.calculator import calculate_consumption, calculate_cost
from app.config import settings
from app.schemas import FuelCalculationRequest, FuelCalculationResponse


app = FastAPI(
    title=settings.app_name,
    version=settings.version,
    description="Simple FastAPI service for calculating vehicle fuel consumption.",
)


@app.get("/health", tags=["system"])
def health_check() -> dict[str, str]:
    return {"status": "healthy"}


@app.get("/version", tags=["system"])
def version() -> dict[str, str]:
    return {
        "app_name": settings.app_name,
        "version": settings.version,
        "environment": settings.environment,
    }


@app.post(
    "/kalkulatorspalania",
    response_model=FuelCalculationResponse,
    tags=["calculator"],
)
def calculate(request: FuelCalculationRequest) -> FuelCalculationResponse:
    try:
        fuel_consumption = calculate_consumption(
            distance_km=request.distance_km,
            fuel_used_liters=request.fuel_used_liters,
        )

        total_cost = None
        if request.fuel_price is not None:
            total_cost = calculate_cost(
                fuel_used_liters=request.fuel_used_liters,
                fuel_price=request.fuel_price,
            )

        return FuelCalculationResponse(
            fuel_consumption=fuel_consumption,
            total_cost=total_cost,
        )

    except ValueError as error:
        raise HTTPException(status_code=400, detail=str(error)) from error


handler = Mangum(app)
