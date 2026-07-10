POPRAWKA AUTOMATYCZNEGO BOOTSTRAPU OBRAZU ECR
==============================================

Pliki:
- bootstrap.tf
- patch_main.py

INSTALACJA

1. Skopiuj pliki do katalogu terraform:

   cp bootstrap.tf ~/fuel-consumption-calculator/terraform/
   cp patch_main.py ~/fuel-consumption-calculator/terraform/

2. Uruchom poprawkę main.tf:

   cd ~/fuel-consumption-calculator/terraform
   python3 patch_main.py

   Skrypt utworzy kopię:
   main.tf.bak

3. Sformatuj i sprawdź konfigurację:

   terraform fmt -recursive
   terraform init -upgrade
   terraform validate
   terraform plan

4. Wdrożenie:

   terraform apply

Terraform wykona kolejność:
ECR -> logowanie Docker -> build -> push :bootstrap -> Lambda -> API Gateway.

5. Usuwanie:

   terraform destroy

Po destroy kolejne terraform apply ponownie utworzy repozytorium, zbuduje obraz
i wyśle go przed utworzeniem Lambdy.

WAŻNE
- Docker Desktop musi działać.
- AWS CLI musi być zalogowane do właściwego konta.
- Build używa:
  --platform linux/amd64
  --provenance=false
  --load

Opcja --provenance=false zapobiega utworzeniu manifestu, którego AWS Lambda
może nie obsługiwać.

PRZYWRACANIE

   cd ~/fuel-consumption-calculator/terraform
   cp main.tf.bak main.tf
   rm -f bootstrap.tf patch_main.py
   terraform fmt -recursive
