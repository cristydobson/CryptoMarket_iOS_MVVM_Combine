# (Swift 5, iOS 16): MVVM, Combine, Rest API, UIKit & XCTest

The **MVVM** design pattern is the most used architecture in professional **iOS development**, along with functional reactive programming, such as **Combine**, to produce clean, easy to read, more maintainable, and testable source code. 

In this project, I used the **Combine** framework (a **Swift API** for Functional Reactive Programming) to fetch data through an API and for alerting **Views** of changes in the **ViewModels**.

All in combination with **UIKit** and _programmatically created_ views and layouts.

## Table of contents
* [MVVM Architectural Pattern](#mvvm)
* [Functional Reactive Programming with Combine](#combine)

## <a name="mvvm"></a>MVVM Architectural Pattern

The MVVM architectural design pattern allows for a better separation of concerns, by keeping the UI logic separate from the Business logic.

Unlike MVC, where the `ViewController` is in charge of presenting the UI as well as handling business logic, on MVVM, the `ViewController` is only in charge of presenting the UI, and requesting its `ViewModel` for ready-to-display data.

### The MVVM pattern has 3 components:

* **Model:** It is owned by the `ViewModel` and holds the app’s data. Models are usually structs, and are used and updated by a `ViewModel`.

* **View:** It is any subclass of `UIView`, such as, view controllers, buttons, views, etc. Its only responsibility is to setup its UI and layout, and bind to its `ViewModel` to later request ready-to-display data.

* **ViewModel:** It is owned by the `View` and it’s responsible for handling all the Business logic. It processes the Model’s data and transforms it into values that can be displayed by the `View`.

  - A `ViewModel` is usually a class, so it can be passed around as a reference.

  - A `ViewModel` uses data bindings to communicate with the `View`, which are ways of alerting each other that something has changed.


### Examples of Data Bindings:

* **Observables:** Use closures as the listeners for changes.
* **Delegation:** Communication through protocols.
* **Observers:** Use Notification Center to add observers and post changes.
* **Functional Reactive Programming:** The handling of asynchronous events over time (e.g., **Combine**, **RxSwift**)


### This Project and MVVM:

* My **Models** are structs that conform to `Codable`, where the JSON data returned through the API gets decoded into, to be later used by the `ViewModel`.

* My **ViewModels** are in charge of fetching data through the API using a service, and transforming it into ready-to-display data. It then communicates through callbacks with its `View` when the transformed data is ready to be handed over.

* My **Views** only concern is to setup the UI and layouts programmatically, and request for ready-to-display data from its `ViewModel`.


## <a name="combine"></a>Functional Reactive Programming with Combine
