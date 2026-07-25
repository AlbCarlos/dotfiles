#!/usr/bin/env python3
import datetime

CUSTOMS_CLEARANCE = 160_000
OLD_VEHICLE_TAX_RATE = 0.6840  # more than 6 years old
RECENT_VEHICLE_TAX_RATE = 0.4810
HIGH_TAX_AGE_THRESHOLD = 6

REPORT_WIDTH = 44


def format_colones(amount: float) -> str:
    return f"₡ {int(amount):,}"

def format_usd(amount: float) -> str:
    return f"$ {int(amount):,}"



def print_row(label: str, value: str) -> None:
    print(f"  {label:<26} {value:>14}")


today = datetime.date.today()
current_year = today.year

price_usd = float(input("Ingrese el precio en dólares (USD): "))
exchange_rate = float(input("Ingrese el tipo de cambio (colones por dólar): "))
car_year = int(input("Ingrese el año del vehículo: "))

car_age = current_year - car_year
tax_rate = (
    OLD_VEHICLE_TAX_RATE
    if car_age > HIGH_TAX_AGE_THRESHOLD
    else RECENT_VEHICLE_TAX_RATE
)

price_colones = price_usd * exchange_rate
taxes = price_colones * tax_rate
total = price_colones + taxes + CUSTOMS_CLEARANCE

print()
print("═" * REPORT_WIDTH)
print("     REPORTE DE IMPORTACIÓN DE VEHÍCULO")
print("═" * REPORT_WIDTH)
print_row("Tipo de cambio", f"₡ {exchange_rate:,.2f} / USD")
print_row("Precio en colones", format_colones(price_colones))
print_row("Impuestos", format_colones(taxes))
print_row("Antigüedad", f"{car_age} años")
print_row("Nacionalización (aduanas)", format_colones(CUSTOMS_CLEARANCE))
print("─" * REPORT_WIDTH)
print_row("TOTAL", format_colones(total))
print_row("TOTAL (USD)", format_usd(total/exchange_rate))
print("═" * REPORT_WIDTH)
print()
