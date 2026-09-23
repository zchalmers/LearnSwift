# LearnSwift - Food Recipe iOS App

An iOS application built with Swift for browsing food items, recipes, and ingredients. This project demonstrates modern iOS development practices including MVVM architecture, programmatic UI, and clean code principles.

## Project Overview

LearnSwift is a food and recipe browsing application that allows users to:
- Browse food items organized by categories
- View detailed recipes and ingredients
- Explore food descriptions and summaries
- Navigate through a clean, intuitive interface

This project serves as a learning resource for Swift and iOS development, showcasing best practices in app architecture and design patterns.

## Features

- 📱 **Native iOS App** - Built for iPhone and iPad
- 🍕 **Food Categories** - Browse items organized by category
- 📝 **Recipe Details** - View comprehensive recipe information
- 🥗 **Ingredients List** - Detailed ingredient breakdowns
- 🎨 **Custom UI** - Programmatic UI with custom components
- 🏗️ **MVVM Architecture** - Clean separation of concerns
- 🧭 **Router Pattern** - Coordinated navigation flow
- 🧪 **Testing** - Unit and UI tests included

## Technologies Used

### iOS Development
- **Swift** - Programming language
- **UIKit** - UI framework
- **SwiftUI** (potential) - Modern declarative UI

### Architecture & Patterns
- **MVVM** (Model-View-ViewModel) - Architecture pattern
- **Router Pattern** - Navigation coordination
- **Presenter Pattern** - Business logic presentation
- **Protocol-Oriented Programming** - Swift best practices

### Development Tools
- **Xcode** - IDE for iOS development
- **XCTest** - Testing framework
- **Git** - Version control

## Project Structure

```
LearnSwift/
├── LearnSwift/                    # Main application
│   ├── AppDelegate.swift          # Application lifecycle
│   ├── SceneDelegate.swift        # Scene lifecycle
│   ├── ViewController.swift       # Base view controller
│   ├── BaseRouter.swift           # Base navigation router
│   ├── ErrorScreenRouter.swift   # Error handling router
│   ├── ViewControllerStackManaging.swift  # Stack management
│   │
│   ├── Model/                     # Data models
│   │   ├── FoodItem.swift         # Food item model
│   │   ├── FoodCategory.swift     # Category model
│   │   ├── FoodRecipe.swift       # Recipe model
│   │   ├── FoodIngredients.swift  # Ingredients model
│   │   └── FoodDataManager.swift  # Data management
│   │
│   ├── Modules/                   # Feature modules
│   │   ├── Category/              # Category browsing
│   │   │   ├── FoodCategoryViewController.swift
│   │   │   ├── FoodCategoryViewModel.swift
│   │   │   ├── FoodCategoryPresenter.swift
│   │   │   └── FoodCategoryRouter.swift
│   │   │
│   │   ├── Item/                  # Item details
│   │   │   ├── FoodItemViewController.swift
│   │   │   ├── FoodItemViewModel.swift
│   │   │   ├── FoodItemPresenter.swift
│   │   │   └── FoodItemRouter.swift
│   │   │
│   │   └── Extensions/            # Swift extensions
│   │       └── UIFont+extension.swift
│   │
│   └── Assets.xcassets/           # Images and assets
│       └── Images/                # Food images
│
├── LearnSwiftTests/               # Unit tests
└── LearnSwiftUITests/             # UI tests
```

## Installation

### Prerequisites

1. **macOS** (Monterey or later recommended)
2. **Xcode 14+** - [Download from App Store](https://apps.apple.com/us/app/xcode/id497799835)
3. **iOS 15.0+** deployment target
4. **Swift 5.5+**

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/zchalmers/LearnSwift.git
   cd LearnSwift
   ```

2. **Open in Xcode**
   ```bash
   open LearnSwift.xcodeproj
   ```
   Or double-click the `.xcodeproj` file in Finder

3. **Select Target Device**
   - Choose a simulator (e.g., iPhone 14 Pro)
   - Or connect a physical iOS device

4. **Build and Run**
   - Press `Cmd + R` or click the Run button
   - Wait for build to complete
   - App will launch in simulator or device

## Usage

### Browsing Categories

1. **Launch the app** - Opens to category selection
2. **Browse categories** - Scroll through available food categories
3. **Tap a category** - View items in that category

### Viewing Food Items

1. **Select a category** - Opens category view
2. **Browse food items** - Scroll through items
3. **Tap an item** - View detailed information
4. **View recipe** - See ingredients and instructions
5. **Navigate back** - Return to previous screen

## Architecture

### MVVM Pattern

```
View (ViewController)
  ↓ User Actions
ViewModel
  ↓ Business Logic
Model (Data)
  ↓ Updates
ViewModel
  ↑ Binding
View (UI Updates)
```

### Key Components

**View Controllers**
- Manage UI presentation
- Handle user interactions
- Bind to ViewModels

**ViewModels**
- Contain presentation logic
- Prepare data for display
- Handle business rules

**Presenters**
- Coordinate between layers
- Format data for views
- Handle complex logic

**Routers**
- Manage navigation flow
- Coordinate screen transitions
- Handle deep linking

**Models**
- Represent data structures
- Conform to protocols (Hashable, Decodable, Identifiable)
- Provide data integrity

## Data Models

### FoodItem
```swift
struct FoodItem: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
    let category: FoodCategory
    let description: String
    let summary: String
}
```

### FoodCategory
```swift
struct FoodCategory: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
}
```

## Testing

### Running Unit Tests

1. **In Xcode**: `Cmd + U`
2. **View Test Navigator**: `Cmd + 6`
3. **Run specific test**: Click diamond next to test

### Running UI Tests

1. **Select UI test target**
2. **Press `Cmd + U`**
3. **Watch simulator execute tests**

### Test Coverage

- Unit tests for ViewModels
- UI tests for navigation flows
- Model validation tests

## Development

### Code Style

- Follow Swift API Design Guidelines
- Use clear, descriptive naming
- Leverage Swift's type system
- Prefer protocol-oriented design

### Adding New Features

1. **Create feature module** in `Modules/`
2. **Implement MVVM components**:
   - ViewController
   - ViewModel
   - Presenter
   - Router
3. **Add data models** if needed
4. **Write tests**
5. **Update router** for navigation

### Custom Components

The app uses programmatic UI with custom components:
- Custom fonts via `UIFont+extension`
- Reusable UI components
- Custom navigation patterns

## Building for Release

1. **Update version** in project settings
2. **Select "Any iOS Device"** as target
3. **Product → Archive**
4. **Distribute** via App Store Connect
5. **Submit for review**

## Troubleshooting

### Build Errors

**"No such module"**
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`

**"Code signing error"**
- Select development team in Signing & Capabilities
- Ensure provisioning profile is valid

**"Simulator not found"**
- Download additional simulators in Xcode Preferences
- Restart Xcode

### Runtime Issues

**App crashes on launch**
- Check console for error messages
- Verify asset catalog is properly configured
- Ensure data models match expected format

**Navigation not working**
- Verify router connections
- Check view controller stack management
- Ensure presenters are properly initialized

**Images not loading**
- Verify asset names match code references
- Check Assets.xcassets for missing images
- Ensure image sets are properly configured

## Learning Resources

This project demonstrates:
- **MVVM Architecture** - Separation of concerns
- **Router Pattern** - Clean navigation
- **Programmatic UI** - No storyboards
- **Protocol-Oriented Programming** - Swift best practices
- **Data Management** - Structured models
- **Testing** - Unit and UI testing

## Future Enhancements

- [ ] Add search functionality
- [ ] Implement favorites/bookmarks
- [ ] Add nutrition information
- [ ] Include cooking timers
- [ ] Add user ratings/reviews
- [ ] Implement meal planning
- [ ] Add shopping list feature
- [ ] Support for dietary restrictions
- [ ] Recipe sharing capabilities
- [ ] Dark mode support

## Contributing

This is a learning project, but contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

## Requirements

- **Deployment Target**: iOS 15.0+
- **Development**: macOS with Xcode 14+
- **Language**: Swift 5.5+
- **Devices**: iPhone and iPad

## License

This project is available for educational purposes.

## Contact

- **GitHub**: [@zchalmers](https://github.com/zchalmers)

## Acknowledgments

- Built as a learning project for iOS development
- Demonstrates modern Swift and UIKit practices
- Food images and data for educational purposes

## Related Project

Backend API for this app: [LearnSwiftBackend](https://github.com/zchalmers/LearnSwiftBackend)
