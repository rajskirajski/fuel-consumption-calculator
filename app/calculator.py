def calculate_consumption(distance_km: float, fuel_used_liters: float) -> float:
    """Calculate fuel consumption in liters per 100 kilometers."""
    if distance_km <= 0:
        raise ValueError("Distance must be greater than zero")

    if fuel_used_liters <= 0:
        raise ValueError("Fuel used must be greater than zero")

    return round((fuel_used_liters / distance_km) * 100, 2)


def calculate_cost(fuel_used_liters: float, fuel_price: float) -> float:
    """Calculate total fuel cost."""
    if fuel_used_liters <= 0:
        raise ValueError("Fuel used must be greater than zero")

    if fuel_price <= 0:
        raise ValueError("Fuel price must be greater than zero")

    return round(fuel_used_liters * fuel_price, 2)
