# ExtendedTableViewController

## Usage

### Displaying Data

The first step to creating an extended table view controller is subclassing. All of the functionality required to 
display and edit sections and rows is built into `EXTableViewController`. Therefore, simply create a new 
subclass of `EXTableViewController`.

```swift
class ViewController: EXTableViewController {}
```


The second step is to create the needed table view cells. Create a new table view cell, subclassing from 
`ConfigurableTableViewCell`. Implement the required protocols.

```swift
class IntTableViewCell: ConfigurableTableViewCell {
    // 1
    class var reuseIdentifier: String { return "IntTableViewCell" }
    class var bundle: Bundle { return Bundle(for: IntTableViewCell.self) }
    class var nib: UINib { return UINib(nibName: "IntTableViewCell", bundle: bundle) }
    
    // 2
    func configure(for value: Int) {
        textLabel?.text = "Value"
        detailTextLabel?.text = String(value)
    }
}
```
1. This allows cells to be easily dequeued. Make sure the reuse identifier matches the storyboard.
2. This method will be called with a value to configure the cell. All configuration should be done here.


Next, the row must be created. This is the object that will represent a specific row in the table view.

```swift
struct IntRow: Row {
    // 1
    typealias DataType = Int
    typealias CellType = IntTableViewCell

    // 2
    var data: Int

    // 3
    init(data: Int) {
        self.data = data
    }
}
```

1. The typealiases are the associated types of the protocol, which fundamentally map a data type to a cell type. Now, whenever this row is used, and IntTableViewCell will automatically be configured with the `data` variable. **Please note that `DataType` must be the same as `CellType.DataType`**. 
2. This is the actual data stored in the row. For instance, this could be customer data, a string, name, etc. This is what will be displayed in the cell.
3. This initializer will almost always be the same: simply set the `data` stored property.


The final step is to simply populate the table view with data, which is extremely simple. In the `ViewController` class, simply override the `generateSections` method. In the body of the method, generate the table view's sections and rows.

```swift
override func generateSections() -> [Section] {
    // 1
    var sections: [Section] = []

    // 2
    var section1 = Section()
    section1.headerTitle = "Section 1"
    // 3
    section1.appendRow(IntRow(data: 1))
    section1.appendRow(StringRow(data: "Awesome"))
    section1.appendRow(IntRow(data: 22))
    // 4
    sections.append(section1)

    var section2 = Section()
    section2.headerTitle = "Section 2"
    section2.appendRow(IntRow(data: 13))
    // 5
    section2.appendRow(StringRow(data: "So cool"))
    section2.appendRow(StringRow(data: "Heck yeah"))
    sections.append(section2)

    return sections
}
```

1. This is the array of sections that will be returned. All sections generated should be added to this array.
2. This is how a new section is created. After this, you can add rows, change the header, etc.
3. Simply initialize new rows (`IntRow(data: 1)`) and append them to the section. It's as easy as that.
4. Make sure to append the section to the array of sections
5. Notice how you are able to append any type of row. Here, I added another type of row, `StringRow`, with no extra overhead.

Now run the project, and you have a fully functioning extended table view controller. Yay!


### Responding to User Interraction

The traditional method of responding to user interraction is still valid. However, it has been optimized to be able to also be declarative. For instance, instead of having to use `tableView(_:didSelectRowAt:)`, you can simply tell the row what to do when tapped using `someRow.onDidSelect = ...`. However, this only works on rows that conform to `RowResponder` in `EXTableViewController`.

This happens because `ExtendedTableViewController` checks for an instance of `RowResponder` for each of the observable events. Therefore, overriding any of the following table view methods in subclasses should call the  `super` implementation as well.

`UITableViewDelegate` Method | `RowResponder` Equivalent
------------------------------------- | -------------------------------
`tableView(_:willDisplay:forRowAt:)` | `onWillDisplay`
`tableView(_:didEndDisplaying:forRowAt:` | `onDidDisplay`
`tableView(_:willSelectRowAt:)` | `onWillSelect`
`tableView(_:didSelectRowAt:)` | `onDidSelect`
`tableView(_:willDeselectRowAt:)` | `onWillDeselect`
`tableView(_:didDeselectRowAt:)` | `onDidDeselect`

```swift
struct IntRow: Row, RowResponder {
    ...
    
    var onWillSelect: ((IndexPath) -> (IndexPath))?
    var onDidSelect: ((IndexPath) -> ())?
    var onWillDeselect: ((IndexPath) -> (IndexPath))?
    var onDidDeselect: ((IndexPath) -> ())?
    var onWillDisplay: ((IndexPath) -> ())?
    var onDidDisplay: ((IndexPath) -> ())?
}
```

```swift
let row = IntRow(data: 500)
row.onDidSelect = { _ in
    print("Just tapped 500!")
}
```

### Extra Cell Configuration

Sometimes it may be required to do extra customization on a cell after it's initial configuration has been completed. This can be done by conforming your row to `ConfigurableRow`, rather than `Row`:

```swift
struct IntRow: ConfigurableRow {
    ...
    
    var configuration: ((IntTableViewCell) -> ())?
}
```

Now, during configuration, the cell will automatically be passed into `configuration`. By setting `configuration` during section generation, the cell can be customized:

```swift
override func generateSections() -> [Section] {
    ...
    
    let row = IntRow(data: 13)
    row.configuration = { cell in
        cell.textLabel?.textColor = .red
    }
    
    ...
}
```

Though this functionality is available, it is recommended to only do this in situations that demand it. Displaying the data should be handled in the table view cell.
