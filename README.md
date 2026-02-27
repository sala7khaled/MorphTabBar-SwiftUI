# Morph Tab Bar
A SwiftUI custom tab bar with a morphing glass effect, expandable actions, and dynamic UI components. Designed for modern iOS apps, it provides a smooth and interactive tab bar experience.

<br>
<br>

## Features
- [x] Morphing glass-style tab bar with smooth animations
- [x] Expandable action menu with customizable buttons
- [x] Dynamic height and scaling for content
- [x] Supports multiple tabs with icons and titles
- [x] Fully written in SwiftUI with reusable components

<br>
<br>

### Light Mode:
<p align="start">
  <img src="https://github.com/user-attachments/assets/08f63466-c231-403e-b480-b6148901510a" width="236">
  &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/light-1.png" width="250">
  <!-- &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/light-2.png" width="250"> -->
  &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/light-3.png" width="250">
</p>

### Dark Mode:
<p align="start">
  <img src="https://github.com/user-attachments/assets/533d75f5-c1e6-49aa-83cf-6d47c1d19857" width="236">
  &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/dark-1.png" width="250">
  <!-- &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/dark-2.png" width="250"> -->
  &nbsp;&nbsp;&nbsp;
  <img src="Screenshots/dark-3.png" width="250">
</p>

<br>


<br>
<br>

## Components
`MorphTabBar.swift` - Custom morphing tab bar with expandable actions <br>
`MorphGlassView.swift` - Glass morphing effect container <br>
`AppTab.swift` - Enum for defining app tabs and their content <br>
`ActionModel.swift` - Model for actions in expandable tab menu <br>
`SkeletonRow.swift` - Placeholder skeleton row for loading state <br>

<br>
<br>

## Usage
```swift
var body: some View {
    ZStack(alignment: .bottom) {
        activeTab.view
        MorphTabBar(activeTab: $bind, isExpand: $bind, actions: []) { i, action in
            // handle action
        }
    }
    .ignoresSafeArea(.all, edges: .bottom)
}
```
