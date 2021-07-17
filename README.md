# DSFDockTile

A helper wrapper around NSDockTile and docktile-related functions.

<p align="center">
    <img src="https://img.shields.io/github/v/tag/dagronf/DSFDockTile" />
    <img src="https://img.shields.io/badge/macOS-10.11+-red" />
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <img src="https://img.shields.io/badge/License-MIT-lightgrey" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" /></a>
</p>

## DockTile Concepts

### AppIcon

Set the dock icon to the application's icon

```swift
// Set the dock icon to the application icon
DSFDockTile.AppIcon.display()
```

### Constant Image

This is a `DSFDockTile` object that displays a single image. Useful for if you have a set of images to display in the docktile that do not change and you want to the constantness.

```swift
static let LockedImage   = NSImage(named: NSImage.Name("padlock-locked"))!
static let UnlockedImage = NSImage(named: NSImage.Name("padlock-unlocked"))!

let LockedDockTileImage = DSFDockTile.ConstantImage(LockedImage)
let UnlockedDockTileImage = DSFDockTile.ConstantImage(UnlockedImage)
...

if application.isEditable {
   UnlockedDockTileImage.display()
}
else {
   LockedDockTileImage.display()
}
```

### Image

This is a `DSFDockTile` object that can display images.

```swift
static let LockedImage   = NSImage(named: NSImage.Name("padlock-locked"))!
static let UnlockedImage = NSImage(named: NSImage.Name("padlock-unlocked"))!

let stateDockTile = DSFDockTile.Image()

...

func viewDidLoad() {
   let image = application.isEditable ? UnlockedImage : LockedImage
   stateDockTile.display(image)
}
```

### View

This is a `DSFDockTile` object that can display the content of a view managed by a view controller

Due to NSDockTile restrictions, the view is not drawn live into the dock as the view is updated. You must call `display()` to update the dock tile with the view's current content whenever a change occurs in the view.

```swift
/// The view controller to display on the docktile
let dockViewController = DockViewController()

/// The docktile instance handling the docktile
lazy var updateDockTile: DSFDockTile.View = {
   dockViewController.loadView()
   return DSFDockTile.View(dockViewController)
}()
...
func doUpdate() {
   // Change the color of the item in the 
   self.dockViewController.foregroundColor = .systemYellow

   // NSDockTile does not update automatically so need to tell it when changes are made
   self.updateDockTile.display()
}
```

### Animation

This is a docktile that can display an animation.  It uses `DSFImageFlipbook` under the seams to handle the animation itself.

```swift
let animatedDockTile: DSFDockTile.Animated = {
   let fb = DSFImageFlipbook()
   let da = NSDataAsset(name: NSDataAsset.Name("animated-gif"))!
   _ = fb.loadFrames(from: da.data)
   return DSFDockTile.Animated(fb)
}()

...

@IBAction func startAnimating(_ sender: Any) {
   animatedDockTile.startAnimating()
}

@IBAction func stopAnimating(_ sender: Any) {
   animatedDockTile.stopAnimating()
}
```

## Attention Concepts

You can request user information via the DockTile of an application by using 

### User Attention

Methods for requesting attention from a user. See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/1428358-requestuserattention) for more details.

#### requestInformationalAttention()

Request that the docktile 'bounce' to inform the user of something informational. The function returns an object which you can use to cancel the attention request.

```swift
let cancellable = DSFDockTile.requestInformationalAttention()
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/criticalrequest)

#### requestCriticalAttention()

Request that the docktile 'bounce' to inform the user of something informational. The function returns an object which you can use to cancel the attention request.

```swift
let cancellable = DSFDockTile.requestCriticalAttention()
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/informationalrequest)

#### Cancellation object (DSFDockTileUserAttentionCancellation)

The user attention methods return an object that can be used to cancel an attention request.

```swift
DSFDockTileUserAttentionCancellation
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/1428683-canceluserattentionrequest)




## Integration

There are demos available in the `Demos` subfolder.

#### Swift package manager

Add `https://github.com/dagronf/DSFDockTile` to your project.


## API

### Core

#### Init with application dock tile

Create a docktile helper for the current application's dock tile.

```swift
init()
```

#### Init with window dock tile

Create a docktile helper for the specified window's dock tile

```swift
init(window: NSWindow)
```

#### Init with a dock tile

Create a docktile helper for the specified docktile

```swift
init(dockTile: NSDockTile)
```

### Badges

#### badgeLabel

Set the label to be displayed on the dock tile. Set to `nil` to remove a badge

```swift
var badgeLabel: String?
```

#### showsApplicationBadge

Sets whether or not the dock tile should be badged with the application icon.

```swift
var showsApplicationBadge: Bool
```

### View Content

#### contentView

Set a view to be displayed in the dock tile. 

```swift
var contentView: NSView?
```


Due to NSDockTile restrictions, the view is not drawn live into the dock, you must call `display()` to update the dock tile with the view's current content whenever a change occurs in the view.

### Image Content

#### image

Set an image to be displayed as the dock tile. Set to nil to remove the image.

```swift
var image: CGImage?
```

### User Attention

Methods for requesting attention from a user. See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/1428358-requestuserattention) for more details.

#### requestInformationalAttention()

Request that the docktile 'bounce' to inform the user of something informational. The function returns an object which you can use to cancel the attention request.

```swift
func requestInformationalAttention() -> DSFDockTileUserAttentionCancellation
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/criticalrequest)

#### requestCriticalAttention()

Request that the docktile 'bounce' to inform the user of something informational. The function returns an object which you can use to cancel the attention request.

```swift
func requestCriticalAttention() -> DSFDockTileUserAttentionCancellation
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/requestuserattentiontype/informationalrequest)

#### Cancellation object (DSFDockTileUserAttentionCancellation)

The user attention methods return an object that can be used to cancel an attention request.

```swift
DSFDockTileUserAttentionCancellation
```

See [Apple's Documentation](https://developer.apple.com/documentation/appkit/nsapplication/1428683-canceluserattentionrequest)

## Thanks

The images (light/dark) in the demo application are thanks to [brgfx on freepix](https://www.freepik.com/free-vector/opposite-adjectives-light-dark_1172843.htm)

Attribution - <a href="https://www.freepik.com/vectors/background">Background vector created by brgfx - www.freepik.com</a>

## License

MIT. Use it and abuse it for anything you want, just attribute my work. Let me know if you do use it somewhere, I'd love to hear about it!

```
MIT License

Copyright (c) 2021 Darren Ford

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
