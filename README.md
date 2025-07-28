# Ordn App

Una aplicación móvil de gestión de tareas desarrollada en Flutter que permite crear, editar, eliminar y visualizar tareas con diferentes niveles de prioridad y fechas de expiración.

## 🏗️ Arquitectura

La aplicación implementa el patrón **MVVM (Model-View-ViewModel)** para mantener una separación clara de responsabilidades:

### Estructura del Proyecto

```
lib/
├── models/               # Modelos de datos
├── viewmodels/          # ViewModels (lógica de negocio)
├── views/               # Interfaces de usuario
├── services/            # Servicios de datos
├── utils/               # Utilidades
└── router/              # Configuración de rutas
```

### Componentes Principales

- **Models**: Entidades de datos con factory constructors para serialización
- **ViewModels**: Gestión del estado y lógica de negocio usando `ChangeNotifier`
- **Views**: Widgets de Flutter que consumen los ViewModels
- **Services**: Capa de persistencia de datos

## 🎯 Características

- ✅ Crear, editar y eliminar tareas
- 🎨 Sistema de prioridades con códigos de color (Bajo, Medio, Alto, Urgente)
- ⏰ Fechas de expiración con contador de tiempo restante
- 💾 Persistencia local usando SharedPreferences
- 🧭 Navegación declarativa con GoRouter

## 🔧 Tecnologías y Patrones

### Gestión de Estado
- **Provider**: Para la inyección de dependencias y gestión reactiva del estado
- **ChangeNotifier**: Patrón Observer para notificar cambios en los ViewModels

### Patrones de Diseño
- **Factory Pattern**: Implementado en `ItemModel` para la deserialización desde JSON
- **Repository Pattern**: `ItemService` actúa como repositorio para operaciones CRUD
- **Observer Pattern**: ViewModels notifican cambios a las vistas

### Navegación
- **GoRouter**: Navegación declarativa con tipado fuerte y paso de parámetros

## 📱 Estructura de Pantallas

### HomeScreen
- Lista de tareas ordenadas por fecha de expiración
- Estado vacío cuando no hay tareas
- FAB para crear nuevas tareas

### FormScreen
- Formulario reutilizable para crear/editar tareas
- Validación en tiempo real
- Selección de fecha y hora personalizada

### DetailsScreen
- Vista detallada de la tarea
- Botones para editar y eliminar
- Confirmación de eliminación

## 🗃️ Modelo de Datos

```dart
class ItemModel {
  final int id;
  final String name;
  final String description;
  final ItemPriorityEnum priority;
  final DateTime createdAt;
  final DateTime expiresAt;
  
  // Factory constructor para deserialización
  factory ItemModel.fromJson(Map<String, dynamic> json) { ... }
}
```

## 🏪 Persistencia de Datos

### ItemService
Implementa las operaciones CRUD utilizando `SharedPreferences`:
- **Create**: Genera IDs automáticamente
- **Read**: Deserializa y ordena tareas por expiración
- **Update**: Actualiza tareas existentes manteniendo el ID
- **Delete**: Eliminación por ID

### Consideraciones de Implementación
- Los datos se almacenan como JSON serializado
- Generación automática de IDs únicos
- Ordenamiento automático por fecha de expiración

## 📊 Gestión de Estado

### ItemViewmodel
```dart
class ItemViewmodel extends ChangeNotifier {
  final ItemService _itemService = ItemService();
  List<ItemModel> _items = [];
  
  List<ItemModel> get items => _items;
  
  Future<void> addOrUpdateItem(ItemModel item) async {
    // Lógica para crear o actualizar
    await fetchItems(); // Refresca la lista
  }
}
```

### Flujo de Datos
1. **View** solicita acción al **ViewModel**
2. **ViewModel** procesa la lógica y llama al **Service**
3. **Service** interactúa con la persistencia
4. **ViewModel** notifica cambios a las **Views**

## 🎨 Componentes UI Reutilizables

### Form Widgets
- `CustomInput`: Campo de texto estilizado
- `CustomButton`: Botón con validación integrada
- `CustomExpirationPicker`: Selector de fecha y hora
- `FormDecorator`: Contenedor con etiqueta y estilo consistente

### Utilidades
- `timeRemaining()`: Calcula y formatea el tiempo restante hasta la expiración
- Sistema de colores por prioridad

## 🚀 Instalación y Uso

```bash
# Clonar el repositorio
git clone [repository-url]

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0          # Gestión de estado
  go_router: ^10.0.0        # Navegación
  shared_preferences: ^2.0.0 # Persistencia local
  intl: ^0.18.0             # Formateo de fechas
```

## 🔍 Consideraciones Técnicas

### Buenas Prácticas Implementadas
- **Separación de responsabilidades** con MVVM
- **Inyección de dependencias** con Provider
- **Validación de formularios** reactiva
- **Gestión de memoria** con dispose de controladores
- **Tipado fuerte** con enums para prioridades
- **Manejo de errores** en operaciones asíncronas

### Optimizaciones
- Lazy loading de datos en el ViewModel
- Reutilización de widgets personalizados
- Ordenamiento eficiente por fecha de expiración
- Uso de `const` constructors para mejor rendimiento

## 📄 Licencia

Este proyecto está bajo la licencia MIT.