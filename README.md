## Ring Chart 

This is a simple ring chart, which is made using UIBezierPath, CoreGraphics, and Trigonometric functions. The purpose is to deal with angles and circle. 

<center><img src="/img/README.png" width="450" height="650"></center> <br> 

## Usage 

```swift
// 1
var someRingChart = RingChartView(
    frame: bounds,
    data: [
        .dataAndColor(data: 10.0, color: .randomColor()),
        .dataAndColor(data: 20.0, color: .randomColor()),
        .dataAndColor(data: 30.0, color: .randomColor()),
        .dataAndColor(data: 40.0, color: .randomColor()),
        .dataAndColor(data: 50.0, color: .randomColor()),
        .dataAndColor(data: 60.0, color: .randomColor())
    ])

// 2
view.addsubView(someRingChart)
```