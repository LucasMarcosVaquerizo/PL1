import random
import os
print("Directorio de trabajo:", os.getcwd())

NUM_REGISTROS = 30000000

with open("estudiantes.csv", "w", encoding="utf-8") as f:
    for i in range(NUM_REGISTROS):
        nombre = f"Estudiante_{i}"
        codigo_carrera = random.randint(0, 100)
        edad = random.randint(18, 40)
        indice = random.randint(0, 10000)

        f.write(f"{nombre},{codigo_carrera},{edad},{indice}\n")

