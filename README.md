# FlickrSearch
This is a basic example of the Flickr image search engine. It will search for any keywords and display infinite scrolling images.The application uses **VIPER architecture** with Unit Test Cases.


## Getting Started

- Clone the repo and run FlickrSearch.xcodeproj
- Run the project and look for any keyword like "Home".
![ezgif-4-70403d73de2f-2-min](https://user-images.githubusercontent.com/7990309/118373371-18480780-b5d4-11eb-95c3-64eb5ebc9c35.gif)

## Class Details

### FlickrSearch

Architecture means a lot to a project. These architecture enables us to reduce code duplication, prevents excessive coupling and standardize a common manner of writing code that gives a popular answer for reoccurring scenario at the same time as growing a software. VIPER is a backronym for View, Interactor, Presenter, Entity, and Router.

#### Views

- **ViewControllers**: This module consists of primary class **PhotoSearchViewController** This view is responsible for sending user actions to the presenter and instructing the presenter what to tell them. its responsbile for fetching, refreshing and searching.

- **Interactor**: This is represented by **PhotoSearchInteractor**.  The interactor is the core of the application because it contains business logic
 
- **Presenter**:This is represented by **PhotoSearchPresenter**. Its responsible for receiving input from the interactor. After receiving data from the interactor, it sends information about user operations to the view for display. It also asks the router/wireframe for navigation

- **Entity**: This is represented by **PhotoBaseModel**.It contains basic model objects used by the Interactor.
  
- **Router**: Has all navigation logic. Describe which screens are displayed and when. It is usually written as a wireframe. This is represented by **PhotoSearchWireframe**


#### Models

- **PhotoBaseModel**: This class represents the response structure of the  service request for the searched text..
- **Photos**: This model represents organization for pictures details. It encapsultes all connected information and therefore generates uniform resource locator for winning images. This category uses codable protocal and used for parsing.

#### Repository

- **PhotoSearchRepository**: This repository class is responsible for preparing the request, fetching and parsing response for consecutive pages. It internally uses **APIManager** to perform the request. 

#### APIManager

This is used to fetch the stream of data, create request.

- **APIManager**: This class is basically used to fetch data from server. It is used to fetch data using http protocol like GET. 


#### UnitTests

This module consists XCTTest classes for testing. 
- **PhotoSearchPresenterTest**:  This class tests the network interactions, Internet connectivity, network errors, internal errors.
- **PhotoSearchInteractorTest**:  This class tests the network interactions, repository.

#### Point To Noted
Code Reviewer ask me to do some code refactoring. I will cover all of possible comments

- **Code Stability**: Code should be break if client want to use core data instead of fetch data from remote server. You shoudl follow the SOLID principle while building the app architecture. which help us to rid out from tightly coupled code. 

- **Class Name**: Every entity in Router Architecture should have meaningfull name
 
- **Cache Mechanism**: In existing code based I used NSCache class provided by apple. There is minor difference between NSCache and Dictionary i.e  NSCache has capability to release memeory when cache size full.

- **Custom Cache Mechanism**: Interviewer may ask you to implement the Custom Cache API. you must to know LRU concept which manage the Cache technique efficiently.

