# LiquidGlassKit

A backport of Apple's Liquid Glass design system for iOS 13 through 18, featuring native API compatibility for seamless in-place substitution and convenient factory methods that allow you to choose between native and recreated components on iOS 26+.

## Overview

LiquidGlassKit brings the beautiful liquid glass visual effects from iOS 26 to older iOS versions. The library provides drop-in replacements for native components with full API compatibility, ensuring your code works seamlessly across iOS versions while automatically leveraging native implementations when available.

## Components

### LiquidGlassView

<img src="https://github.com/user-attachments/assets/a08f6427-def6-4ed6-802f-8d697608f09b" width="323" alt="LiquidGlassView">

The core rendering engine that produces the liquid glass effect using Metal shaders. It captures background content behind the view and applies sophisticated glass-like visual effects including:

- **Refraction**: Simulates light bending through glass with configurable refractive index
- **Chromatic Dispersion**: Prismatic color separation on edges for realistic glass appearance
- **Fresnel Reflections**: Edge lighting that intensifies at viewing angles
- **Glare Highlights**: Directional specular streaks that respond to surface normals
- **Shape Merging**: Smooth union of multiple rectangles with customizable corner rounding

The view utilizes `CABackdropLayer` and a zero-copy bridge to efficiently capture and process background content.

> [!WARNING]
> The LiquidGlassKit also includes an App Store-safe alternative background capture method that relies solely on public APIs. This approach uses root view rendering instead of the private CABackdropLayer, making it more CPU-intensive while preserving the full liquid glass effect.

### LiquidLensView

<img src="https://github.com/user-attachments/assets/60423c8a-a6c7-469e-acda-65e8debbdc8d" width="330" alt="LiquidLensView">

A custom implementation of the private `_UILiquidLensView` used in iOS 26's `UITabBar`. This component provides:

- **Resting State**: A semi-transparent white pill that displays when not interacting
- **Lifted State**: Morphs into a full `LiquidGlassView` when the tab bar item is lifted
- **Acceleration-Based Animation**: Tracks position history and applies squash/stretch effects based on movement acceleration
- **Smooth Transitions**: Spring-based animations between resting and lifted states

> [!NOTE]
> The view implements the `AnyLiquidLensView` protocol, enabling it to serve as a drop-in replacement for the private `_UILiquidLensView` class.

### LiquidGlassEffectView

<img src="https://github.com/user-attachments/assets/be5e4bb9-ecd0-4fae-9655-9bbcf1faded6" width="300" alt="LiquidGlassEffectViewLight">
<img src="https://github.com/user-attachments/assets/a9ae82df-2982-4bea-bc09-c7f4d59e0808" width="300" alt="LiquidGlassEffectViewDark">

A `UIVisualEffectView`-compatible wrapper that provides liquid glass effects through the standard visual effect API. Supports:

- **LiquidGlassEffect**: Individual glass elements with configurable styles (regular, clear)
- **LiquidGlassContainerEffect**: Combined glass rendering for multiple nested elements
- **Interactive Mode**: Optional touch-responsive behavior
- **Tint Customization**: Per-effect color tinting

> [!NOTE]
> LiquidGlassKit declares the `AnyVisualEffectView` protocol, which both native `UIVisualEffectView` and the custom `LiquidGlassEffectView` conform to, enabling seamless interoperability between implementations.

### LiquidGlassSlider

<img src="https://github.com/user-attachments/assets/abfb38eb-9df1-4ed1-bcff-590b9e42c975" width="280" alt="LiquidGlassSlider">

A fully compatible `UISlider` replacement that replicates iOS 26's liquid glass sliding style. Features include:

- **Dual Thumb States**: 
  - **Contracted**: Solid filled pill in resting state
  - **Expanded**: Transparent liquid glass effect during interaction
- **Smooth Morphing**: Spring-based animations between thumb states
- **Rubber-Band Physics**: Elastic resistance when dragging past bounds
- **Haptic Feedback**: Light and medium impact feedback at track edges
- **Full UISlider API**: Complete compatibility with all standard slider properties and methods

> [!NOTE]
> LiquidGlassKit declares the `AnySlider` protocol, which both native `UISlider` and the custom `LiquidGlassSlider` conform to, ensuring full API compatibility across implementations.

### LiquidGlassSwitch

<img src="https://github.com/user-attachments/assets/2bc4cede-d808-416e-a0a3-fabb15d90f18" width="314" alt="LiquidGlassSwitch">

A `UISwitch` replacement that replicates iOS 26's liquid glass sliding style. Features include:

- **Dual Thumb States**: Same contracted/expanded morphing as the slider
- **Edge-Based Toggling**: State changes when thumb reaches track edges during drag
- **Tap and Drag Support**: Distinguishes between quick taps and drag gestures
- **Haptic Feedback**: Impact feedback on state changes
- **Full UISwitch API**: Complete compatibility with all standard switch properties

> [!NOTE]
> LiquidGlassKit declares the `AnySwitch` protocol, which both native `UISwitch` and the custom `LiquidGlassSwitch` conform to, ensuring full API compatibility across implementations.

### ZeroCopyBridge

A utility class that bridges rendering into Metal textures using zero-copy techniques via IOSurface. By avoiding unnecessary memory copies, it further improves performance and helps maintain high frame rates throughout the liquid glass rendering pipeline.

## Usage

### Factory Methods

All components provide factory methods that automatically select the appropriate implementation:

```swift
// Automatically uses native UISwitch on iOS 26+, custom on older versions
let switch = LiquidGlassSwitch.make(isNative: true)

// Automatically uses native UISlider on iOS 26+, custom on older versions
let slider = LiquidGlassSlider.make(isNative: true)

// Automatically uses native UIVisualEffectView on iOS 26+, custom on older versions
let effectView = VisualEffectView(effect: LiquidGlassEffect(style: .regular, isNative: true))
```

### UILiquidLensView

Example usage with private view and open alternative:

```swift
var liquidLensView: UILiquidLensView?

if #available(iOS 26.0, *) {
    let viewClass: AnyClass? = NSClassFromString("_UILiquidLensView")
    class_addProtocol(viewClass, AnyLiquidLensView.self)
    liquidLensView = (viewClass as? AnyLiquidLensView.Type)?.init() as? UILiquidLensView
} else {
    liquidLensView = LiquidLensView()
}
```

## Requirements

- iOS 13.0+
- Xcode 14.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add LiquidGlassKit to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/LiquidGlassKit.git", from: "1.0.0")
]
```

Or add it through Xcode:
1. File → Add Packages...
2. Enter the repository URL
3. Select the version or branch

### Bazel

A `BUILD` file is provided for Bazel users, containing build rules for both the library and Metal shader resources.

## TODO

1. Utilize the existing multiform morphing shader in container effect view.
2. Implement transformations on fragment shader level to better mimic liquid glass.
3. Add more components and extend functionality of existing ones.
4. Improve responsiveness and performance on iOS 17+ with native SwiftUI layer support in shaders.

> [!IMPORTANT]
> Bookmark this project to stay updated with the latest developments. Contributions are welcome! Whether it's bug fixes, feature enhancements, or documentation improvements, your help makes this project better for everyone.

---

Copyright © 2025 DnV1eX
