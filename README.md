# App - Flutter

Aplicativo mobile desenvolvido em **Flutter** que consome a API pública **TheMealDB** para exibir receitas culinárias.

O objetivo do projeto é fornecer uma experiência simples e intuitiva, permitindo que o usuário pesquise receitas, visualize detalhes completos e salve suas receitas favoritas.

---

# Funcionalidades

O aplicativo possui as seguintes funcionalidades:

## Tela Inicial (Home)

- Campo de pesquisa de receitas.
- Exibição de uma sugestão de receita aleatória.
- Receitas em destaque.
- Listagem de categorias.
- Acesso à tela de favoritos.

---

## Tela de Detalhes

Exibe informações completas da receita:

- Imagem da receita.
- Nome.
- Categoria.
- País de origem.
- Lista de ingredientes.
- Modo de preparo.
- Botão para adicionar aos favoritos.

---

## Tela de Favoritos

Permite visualizar as receitas salvas pelo usuário.

Funcionalidades:

- Visualizar receitas favoritas.
- Remover receitas dos favoritos.
- Persistência local dos dados.

---

# API utilizada

O projeto utiliza a API pública TheMealDB.

Documentação:

https://www.themealdb.com/api.php

Principais endpoints utilizados:

### Receita aleatória

```
https://www.themealdb.com/api/json/v1/1/random.php
```

### Buscar receitas

```
https://www.themealdb.com/api/json/v1/1/search.php?s=
```

### Listar categorias

```
https://www.themealdb.com/api/json/v1/1/categories.php
```

### Receitas por categoria

```
https://www.themealdb.com/api/json/v1/1/filter.php?c=
```

---

#  Tecnologias utilizadas

- Flutter
- Dart
- HTTP
- Shared Preferences
- Material Design

---

# Modelos implementados

## meal.dart

Responsável por representar uma receita.

Atributos principais:

- idMeal
- name
- category
- area
- instructions
- thumbnail
- ingredients

---

## category.dart

Responsável por representar uma categoria.

Atributos:

- idCategory
- name
- thumbnail
- description

---

## favorite.dart

Responsável por representar uma receita favoritada.

Atributos:

- idMeal
- name
- thumbnail

---

# Arquitetura utilizada

O projeto utiliza uma arquitetura em camadas:

## Camada de apresentação (Presentation)

Responsável pelas telas e interação com o usuário.

Exemplos:

- HomeScreen
- MealDetailScreen
- FavoritesScreen

---

## Camada de repositório (Repository)

Intermedia a comunicação entre a interface e os serviços.

Exemplo:

```
meal_repository.dart
```

---

## Camada de serviços (Service)

Responsável pelo consumo da API e persistência local.

Exemplos:

```
meal_service.dart

favorite_service.dart
```

---

# Persistência local

Os favoritos são armazenados utilizando:

```
SharedPreferences
```

Os dados permanecem salvos mesmo após o fechamento do aplicativo.

---

# Como executar o projeto

## 1. Clonar o repositório

```bash
git clone <url-do-repositorio>
```

---

## 2. Acessar a pasta

```bash
cd Cook_time
```

---

## 3. Instalar as dependências

```bash
flutter pub get
```

---

## 4. Executar o aplicativo

```bash
flutter run
```

---

# Dependências utilizadas

Exemplo do `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  http: ^1.2.0

  shared_preferences: ^2.2.2
```

---

# Objetivo do projeto

Desenvolver uma aplicação mobile moderna utilizando Flutter, aplicando conceitos como:

- Consumo de APIs REST;
- Persistência local de dados;
- Arquitetura em camadas;
- Navegação entre telas;
- Manipulação de estados;
- Desenvolvimento de interfaces responsivas.

---
