from pydantic import BaseModel, Field


class FuelCalculationRequest(BaseModel):
    distance_km: float = Field(
        ...,
        gt=0,
        description="Distance in kilometers.",
        examples=[500],
    )
    fuel_used_liters: float = Field(
        ...,
        gt=0,
        description="Fuel used in liters.",
        examples=[40],
    )
    fuel_price: float | None = Field(
        default=None,
        gt=0,
        description="Fuel price per liter.",
        examples=[6.5],
    )


class FuelCalculationResponse(BaseModel):
    fuel_consumption: float = Field(
        description="Fuel consumption in liters per 100 km.",
        examples=[8.0],
    )
    total_cost: float | None = Field(
        default=None,
        description="Total trip cost.",
        examples=[260.0],
    )
