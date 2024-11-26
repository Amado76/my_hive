
# My Hive: A Study Project on Micro Frontends and Whitelabel Applications

My Hive is a study project created to experiment with and apply advanced techniques such as micro frontend architecture, multi-layered translation (by language and business logic), Whitelabel applications, and user profiles with individual themes. The concept revolves around building an app for homeschooling communities, enabling features like receiving notifications, managing profiles, and handling registrations seamlessly.

<div align="center">
  <img src="https://github.com/user-attachments/assets/2176919c-7b3f-42c8-ac7d-9d345ce663ad" alt="Screenshot 1" width="300" style="margin: 10px;">
  <img src="https://github.com/user-attachments/assets/515af315-cfcf-498e-a63d-77311c069fb1" alt="Screenshot 2" width="300" style="margin: 10px;">
  <img src="https://github.com/user-attachments/assets/1a24ae80-329b-407b-a98f-33d2ffc353bc" alt="Screenshot 3" width="300" style="margin: 10px;">
</div>




# Core Features and Approach

## 1. Micro Frontend Architecture
The project is designed around a micro frontend architecture, adhering to the principle that each module should be:


Independent: Modules can be tested independently, making them easily replaceable if needed.
Scalable: Facilitates adding new features without affecting existing functionality.
Maintainable: Clean separation of concerns ensures that changes in one module do not disrupt others.
This approach aligns with SOLID principles, balancing simplicity and functionality while avoiding over-engineering.

![image](https://github.com/user-attachments/assets/80ca88c9-4dc4-4203-aebb-e8b584b6bead)

## 2. State Management with BLoC

I implemented the BLoC (Business Logic Component) pattern for state management, ensuring clear separation of business logic from UI components, and  making the app modular and testable.

## 3. Dependency Injection and Navigation with Modular
The Modular package was employed to:

Organize micro frontends.
Manage routes dynamically.
Handle dependency injection, promoting reusability and testability across modules.
Multi-Layered Translation System
Translation is a core feature of the project, addressing two layers of complexity:

## 4. Language Localization: Traditional translations for multiple languages (e.g., English, Portuguese, Spanish).
Business Context Customization: Translations vary based on the community's specific terminology.
For example:
Community A: Refers to groups as "Family" (EN), "Família" (PT), and "Familia" (ES).
Community B: Uses "Group" (EN), "Grupo" (PT), and "Grupo" (ES) instead.
I created a custom wrapper for the Intl package, enabling each micro frontend to define its own translations and accommodate differences in language and business logic.

## 5. Whitelabel and Theming
The app supports white labeling, allowing customization for different communities. Each user profile can have its own theme, providing a personalized experience for users with multiple profiles across different organizations.

### Why My Hive?
This project demonstrates how to build scalable, modular, and adaptable applications using Flutter. It’s designed to serve as a foundation for apps targeting diverse audiences, where customizability, translation, and modularity are key. By combining best practices in architecture with Flutter's robust ecosystem, My Hive exemplifies how to create maintainable and future-proof applications.

Feel free to explore the repository to learn more about the details of the implementation and the techniques applied!
