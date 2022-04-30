# _Posts App_

App for read post using swift.

## Installation

Clone the repository and run the next command on your terminal.

```sh
pod install
```

## Pods

Three third party libraries where used on this proyect

| Plugin | Link | Usage |
| ------ | ------ | ------ |
| Alamofire | [Cocoapods](https://cocoapods.org/pods/alamofire) | Used as an alternative to URLSession for its simplisity and compatibility with the Swift Codable Protocol. |
| RealmSwift | [Cocoapods](https://cocoapods.org/pods/RealmSwift) | Used as an alternative to CoreData to persist data collections.
| ReachabilitySwift | [Github](https://github.com/ashleymills/Reachability.swift) | Used to detect and notify changes on the network reachability.

## Development


- The projects is based on an MVC arquitecture, using xib files as views with its respective controller.
- Managers where added for managing the DB and the API communication.
- A repository pattern is used to manage all data handling to separate third party libraries as much as posible.
- The Codable Protocol has been implemented in order to parse the data with the lasted version of AF.
- Test Cases for Model parsing has been implemented to ensure a reliable data parsing.

## Feature TODO

- Add an empty message to favorites pages
- Add alerts to show errors
- Add an app icon
- Add default empty labels when data is null
- Consider adding color palette
- Add Localizable Strings to support different languages
- Add Spinner
- Add Landscape support

