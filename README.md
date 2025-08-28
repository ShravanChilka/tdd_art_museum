# TDD Art Museum

A Flutter project built to demonstrate **Test-Driven Development (TDD)** principles and best practices.  
This repository focuses on **writing tests first** to guide the development process, ensuring maintainable, reliable, and clean code.

---

## Overview

This project is not about building a production-grade art museum app.  
Instead, it serves as a **case study** on how to apply TDD in Flutter development.

Key learning objectives:

- Writing **unit**, **widget**, and **integration** tests in Flutter.
- Structuring tests to drive feature development.
- Maintaining clean architecture while achieving high test coverage.

---

## What This Project Showcases

- **Red-Green-Refactor Cycle**: Every feature starts with a failing test (Red), moves to passing implementation (Green), and ends with code improvements (Refactor).
- **Separation of Concerns**: Business logic, UI, and data handling are structured for testability.
- **Mocking & Stubs**: External dependencies (e.g., repositories, services) are mocked to isolate test scenarios.
- **Test Organization**: Clear folder structure for different test types.

---

## Tech Stack

- **Flutter** – Core framework
- **Dart** – Language
- **flutter_test** – Built-in Flutter testing library
- **mocktail / Mockito** – For mocking dependencies
- **CI-ready** – Tests can run in pipelines for continuous validation

---

## Test Coverage

The project demonstrates testing across three levels:

1. **Unit Tests**

   - Validate business logic in isolation
   - Example: Verifying state transitions in a ViewModel

2. **Widget Tests**

   - Test individual UI components with simulated interactions
   - Example: Ensuring buttons trigger expected callbacks

3. **Integration Tests**
   - Verify multiple components work together as expected
   - Example: Navigation flow between screens under test conditions

---

## Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/ShravanChilka/tdd_art_museum.git
   ```
