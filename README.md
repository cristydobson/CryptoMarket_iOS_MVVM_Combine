# (Swift 5, iOS 16): MVVM, Combine, Rest API, UIKit & XCTest

The **MVVM** design pattern is the most used architecture in professional **iOS development**, along with functional reactive programming, such as **Combine**, to produce clean, easy to read, more maintainable, and testable source code. 

In this project, I used the **Combine** framework (a **Swift API** for Functional Reactive Programming) to fetch data through an API and for alerting **Views** of changes in the **ViewModels**, as well as, to setup a Timer that refreshes the data every 10 seconds.

All in combination with **UIKit** and _programmatically created_ views and layouts.

## Table of contents
* [MVVM Architectural Pattern](#mvvm)
* [Functional Reactive Programming with Combine](#combine)


## <a name="mvvm"></a>MVVM Architectural Pattern

The MVVM architectural design pattern allows for a better separation of concerns, by keeping the UI logic separate from the Business logic.

Unlike MVC, where the `ViewController` is in charge of presenting the UI as well as handling business logic, on MVVM, the `ViewController` is only in charge of presenting the UI, and requesting its `ViewModel` for ready-to-display data.

### The MVVM pattern has 3 components:

![MVVM_Architechture](Assets/MVVM/MVVM-Architecture.png)</br>

* **Model:** It is owned by the `ViewModel` and holds the app’s data. Models are usually structs, and are used and updated by a `ViewModel`.

* **View:** It is a `UIViewController` or any subclass of `UIView`, such as, buttons, views, etc. Its only responsibility is to setup its UI and layout, and bind to its `ViewModel` to later request ready-to-display data.

* **ViewModel:** It is owned by the `View` and it’s responsible for handling all the Business logic. It processes the Model’s data and transforms it into values that can be displayed by the `View`.

  - The `ViewModel` is usually a class, so it can be passed around as a reference.

  - The `ViewModel` uses data and user action bindings to communicate with the `View`, which are ways of alerting each other that something has changed.

  ![Data_Bindings](Assets/MVVM/Data_Bindings.png)<br>


### Examples of Data Bindings:

* **Observables:** Use closures as the listeners for changes.
* **Delegation:** Communication through protocols.
* **Observers:** Use Notification Center to add observers and post changes.
* **Functional Reactive Programming:** The handling of asynchronous events over time (e.g., **Combine**, **RxSwift**)


### This Project and MVVM:

* My **Models** are structs that conform to `Codable`, where the JSON data returned through the API gets decoded into, to be later used by the `ViewModel`.

![My_Models](Assets/MVVM/MVVM-My_Models.png)<br>

* My **ViewModels** are in charge of fetching data through the API using a service, and transforming it into ready-to-display data. It then communicates through callbacks with its `View` when the transformed data is ready to be handed over.

![My_ViewModels](Assets/MVVM/MVVM-My_ViewModels.png)<br>

* My **Views** only concern is to setup the UI and layouts programmatically, and request for ready-to-display data from its `ViewModel`.

![My_Views](Assets/MVVM/MVVM-My_Views.png)<br>

## <a name="combine"></a>Functional Reactive Programming with Combine

The Combine framework allows you to write functional reactive code to handle asynchronous events delivered by a `Publisher` (Observable) over time, and acted on by a `Subscriber` (Observer) who receives those events.

> A very important rule of a subscription is that a `Subscriber` can only have one subscription.


### This Project and Combine:

#### Setting up the Publishers and Subscribers

**1.** Created a service protocol to fetch data through an API. The data fetching method returns a `Future`, which is the promise of a single element published asynchronously. This `Future` can be a generic object of type T or an API error.

  - I made the published element of a generic type, so it can successfully return any kind of JSON format.
  
  ![Combine 01](Assets/Combine/Combine_01.png)<br>


**2.** Created a Singleton class that conforms to the service protocol, and implements the data-fetching method.

  - After starting the data task publisher, we must make sure that the http response status code is between 200 and 299, so we can get our expected data.
  
  ![Combine 2.1](Assets/Combine/Combine_02-2_1.png)<br>

  - If our data was fetched successfully, we then decode it into one of our models that conforms to `Codable`.
  
  ![Combine 2.2](Assets/Combine/Combine_02-2_2.png)<br>

  - We then subscribe to be alerted if any error occurred that will keep us from successfully fetching our expected data.
  
  ![Combine 2.3](Assets/Combine/Combine_02-2_3.png)<br>

  - If everything went well, we then publish our models containing the decoded data.
  
  ![Combine 2.4](Assets/Combine/Combine_02-2_4.png)<br>


**3.** Created Publishers in the `ViewModel` that will alert the `ViewController` of the newly created data.

  ![Combine 03](Assets/Combine/Combine_03.png)<br>


**4.** We then setup the `ViewController` as the `Subscriber` to the previous `Publisher` through binding, which will listen for any changes and update its UI accordingly.

  ![Combine 04](Assets/Combine/Combine_04.png)<br>


#### Example:

When tapping on a Crypto currency `CollectionViewCell`, the `ViewModel` in charge of fetching the data through the service:

* if successful, it will store the data in the Publishers `asks` and `bids`, and the `Subscriber` `ViewController` will then receive the published elements and display them,

* if not successful, then the `ViewModel` will let the `ViewController` know through the `presentStatsAlert` `Publisher`, that it must show an alert to the user before popping the `ViewController` from the `NavigationController`.


#### Refreshing Data

Created a `Timer` to trigger a call to refresh the data every 10 seconds, by refetching new data through the API.

![Timer_Code](Assets/Timer/Timer-01.png)<br>











