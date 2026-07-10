#!/usr/bin/env python3
"""Dodaje zależność bootstrap_image do rootowego modułu Lambda w terraform/main.tf."""

from pathlib import Path
import re
import sys

main_tf = Path(__file__).resolve().parent / "main.tf"

if not main_tf.exists():
    sys.exit(f"Błąd: nie znaleziono {main_tf}")

text = main_tf.read_text(encoding="utf-8")

if "terraform_data.bootstrap_image" in text:
    print("main.tf już zawiera zależność terraform_data.bootstrap_image.")
    sys.exit(0)

match = re.search(r'module\s+"lambda"\s*\{', text)
if not match:
    sys.exit('Błąd: nie znaleziono bloku module "lambda" w terraform/main.tf')

start = match.start()
brace_start = text.find("{", match.start())
depth = 0
end = None

for index in range(brace_start, len(text)):
    char = text[index]
    if char == "{":
        depth += 1
    elif char == "}":
        depth -= 1
        if depth == 0:
            end = index
            break

if end is None:
    sys.exit('Błąd: blok module "lambda" nie ma poprawnego zamknięcia.')

block = text[start:end + 1]

dependency = """
  depends_on = [
    terraform_data.bootstrap_image,
    module.iam,
    module.cloudwatch,
  ]
"""

new_block = block[:-1].rstrip() + "\n\n" + dependency.rstrip() + "\n}"
new_text = text[:start] + new_block + text[end + 1:]

backup = main_tf.with_suffix(".tf.bak")
backup.write_text(text, encoding="utf-8")
main_tf.write_text(new_text, encoding="utf-8")

print(f"Gotowe: zmodyfikowano {main_tf}")
print(f"Kopia poprzedniego pliku: {backup}")
