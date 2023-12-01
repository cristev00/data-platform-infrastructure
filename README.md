
# Plataforma de Datos en la Nube 🌐

¡Bienvenido a la Plataforma de Datos en la Nube! Este proyecto proporciona una solución robusta y eficiente desplegada en la nube con tecnologías líderes de AWS.

## Tecnologias 🤖

- VPC (Red virtual)
- IAM (Administración de identidades y accesos)
- Glue (Integrador de datos)
- RDS (Base de datos relacional o analitica)
- KMS (Servicio de control de claves criptograficas)
- Secrets Manager (Herramientas de administración de creenciales)
- S3 (Almacenamiento de lago de datos)
- Cognito (Herramienta de autenticación y autorización de usuarios)
- SNS (Servicio de notificaciones y mensajeria en relación a cognito)

## Visión General 👁️

Este workflow procesará archivos crudos alojados en s3 mediante una ETL en glue, el job y el crawler serviran para leer nuestros datos crudos y, de esta forma, inferir el esquema de los mismo, colocando la data también en la instancia de RDS. La demás infraestructura se adapta a las necesidades del negocio y de cubrir lo más posible aplicando seguridad, versatibilidad y flexibilidad.

## Arquitectura 👷‍♂️

La plataforma está diseñada para ofrecer por  medio de la creación de la infraestructura administrada por Terraform, lo siguiente:

- **Integración de Datos Simplificada:** Utilizando [AWS Glue](https://aws.amazon.com/glue/), garantizamos una integración de datos fluida y eficiente.

- **Almacenamiento Escalable:** Hacemos uso de [Amazon S3](https://aws.amazon.com/s3/) como Data Lake, asegurando un almacenamiento flexible y altamente escalable.

- **Base de Datos Poderosa:** [Amazon RDS](https://aws.amazon.com/rds/) se emplea para gestionar nuestra base de datos relacional o analítica, proporcionando confiabilidad y rendimiento.

- **Autenticación Segura:** [Amazon Cognito](https://aws.amazon.com/cognito/) se encarga de la autenticación y autorización de usuarios, brindando seguridad sin complicaciones.

- **Gestión de Credenciales Eficiente:** [AWS Secrets Manager](https://aws.amazon.com/secretsmanager/) garantiza una gestión segura y eficaz de las credenciales.


 _En base a esto, en la siguiente figura se muestran las tecnologias creadas y su relación en un entorno real:_

![arquitectura.png](images%2Farquitectura.png)

## Puesta en marcha 🥊

Para poner en marcha, sigue estos simples pasos:

Clona este repositorio: git clone https://github.com/cristev00/data-platform-infrastructure.git o descarga el archivo .zip y descomprimelo.

¡Y listo!, para continuar, ten en cuenta los requisitos..

## Requisitos 👀

La creación y ejecución del ecosistema de infraestructura fue dado con:

- terraform 1.2.9 (comprobar con `terraform -v`) [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) - (se recomienda instalar `tfenv` para administrar diferentes versioens de terraform) [Tfenv](https://spacelift.io/blog/tfenv)
- aws-cli 2.13.16 (comprobar con `aws --version`) [AWS CLI](https://aws.amazon.com/cli/)
- python 3.11 (comprobar con `python3 --version` o `python --version`) [Python3](https://realpython.com/installing-python/)
- git version 2.39.2 (comprobar con `git --version`) [Git](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalaci%C3%B3n-de-Git)

## Inicio Rápido 🚀🫰

**¡Importante!** Antes de ejecutar cualquier script de aprovisionamiento, asegúrate de entender los costos asociados y ajusta la configuración según tus necesidades específicas.

Antes de comenzar, asegúrate de revisar la documentación detallada de AWS para cada servicio utilizado y sigue las mejores prácticas de seguridad y gestión de recursos en la nube.

1. Una vez teniendo aws-cli, realizar la configuración de las credenciales. Se puede hacer con el comando `aws configure`, colocando los datos de su cuenta en los campos: `AWS Access Key ID`, `AWS Secret Access Key` y `AWS Region`. Si no cuenta con ellos debe ir primero a la consola de AWS en su cuenta y dentro del servicio IAM en el apartado My security credentials, crearlas. Verifique su archivo de credenciales en `.aws/credentials`.
(Garantizar tener un usuario con acceso a AWS y permisos suficientes para crear recursos.)

![img1.png](images%2Fimg1.png)

2. Luego de tener las credenciales activas, se debe garantizar tener el repositorio o directorio `data-platform-infrastructure` en su local. 
3. Dentro del directorio anterior, parado en la raiz, realizar `terraform init`
4. Luego de la correcta validación del estado y los recursos, realizar `terraform apply -var-file pwd.tfvars`
5. Evaluar el plan que entrega terraform y digitar `yes` para proceder con la creación
6. Después de tener la correcta aplicación de 25 recursos, ya la infraestuctura estára provisionada en la región de us-east-1 en su cuenta AWS. (La creación de la instancia de RDS puede tardar aproximadamente 10 minutos)

![img2.png](images%2Fimg2.png)

7. Una vez hecho esto puede ir a su consola AWS y comprobar toda la infrastructura creada.
8. Se recomienda una vez terminada la revisión lanzar desde la raiz del proyecto el comando `terraform destroy -auto-approve -var-file pwd.tfvars` para eliminar la infraestructura y no caer en gastos adicionales en la facturación. 

![img3.png](images%2Fimg3.png)

## Estrategia de Despliegue 🌀

La implementación se realiza utilizando archivos de aprovisionamiento y configuración propios de Terraform. Asegúrate de revisar y entender cada configuración antes de ejecutar el despliegue. Se recomienda seguir las mejores prácticas de seguridad y monitoreo después del despliegue. 

Otra estrategia de despliegue automaticó a implementar, es crear un archivo config.yml en Circleci o un jenkisfile en Jenkins, para el despliegue de un pipeline que ejecute los comandos de terrraform y aprovisione la infraesturctura.

## Contribuciones y problemas 🥸

¡Contribuciones son bienvenidas! Si encuentras algún problema o tienes alguna mejora que sugerir, por favor abre un problema o envía una solicitud.

---

**Nota:** Este README es solo un punto de partida. ¡Personalízalo según las necesidades específicas! 🎨