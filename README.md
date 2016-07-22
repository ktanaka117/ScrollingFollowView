# ScrollingFollowView
ScrollingFollowView is a simple view which follows UIScrollView scrolling.

## How to Use

```swift
@IBOutlet weak var scrollingFollowView: ScrollingFollowView!

// NSLayoutConstraint of moving position.
@IBOutlet weak var scrollingFollowViewTopConstraint: NSLayoutConstraint!

override func viewDidLoad() {
    super.viewDidLoad()

    // First setup
    scrollingFollowView.setup(constraint: scrollingFollowViewTopConstraint, isIncludingStatusBarHeight: true)
}
```

```swift
func scrollViewDidScroll(scrollView: UIScrollView) {
	// scrollingFollowView follows UIScrollView scrolling.
    scrollingFollowView.didScrolled(scrollView)
}
```

## Runtime Requirements

- iOS8.0 or later
- Xcode 7.0

## Contact
Please give me contact about this library, mension on Twitter.
[@ktanaka117](https://twitter.com/ktanaka117)

## License

ScrollingFollowView is released under the MIT license. Go read the LICENSE file for more information.