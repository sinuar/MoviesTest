Datos de acceso a la prueba:

api_key:
a2540b1797d974a24f35f1e2381611dc

request_token:

En caso de necesitar modificar las credenciales, hacerlo en el enum Credentials, dentro del grupo Networking.

Username: sinuar
Password: sinu1357

// ARQUITECTURA

Se utilizó el patrón de arquitectura Model-View-ViewModel (MVVM), adecuado y ágil para estructurar y organizar proyectos no demasiado grandes. Además, ayuda a facilitar pruebas unitarias, en el caso de que sean implementadas.

Se agregó un Coordinator, buscando desacoplar la navegación del ViewController.

// WRAPPERS

Se incluyen dos wrappers:

@UsesLayout - Se utiliza para aplicar el comando TranslateAutoresizingMaskIntoConstraints = false

@ViewModelState - Es un Observer reutilizable empleado para informar a las Vistas del cambio de estado del ViewModel mediante el "didSet".

// LOADER

Se agregó un loader cuya duración coincide con el tiempo de espera del servicio.

// LOGIN MODULE

Se construyeron dos TextFields, un Button y un Label. La interfaz se desplaza en caso de que aparezca el keyboard del dispositivo.

// FILM COLLECTION MODULE

Se agregó el CollectionView. 
Se realizó la descarga de las imágenes de cada película. 
Se creó la celda para mostrar la información de cada película, pero sólo se implementó la imagen. 

Se personalizó la NavigationBar y se implementó un RightBarButtonItem sin funcionalidad.

// GENERALES
Se procuró seguir principios SOLID y buenas prácticas como ser explícitos en los DataTypes para reducir tiempos de ejecución. 
Aunque es un proyecto pequeño, es una buena práctica.

