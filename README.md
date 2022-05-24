# Mobile iOS application BooksAD
## General information about the application
The BooksAD app is an app for posting book ads

<img width="150" alt="Снимок экрана 2022-05-23 в 23 19 42" src="https://user-images.githubusercontent.com/97699156/169899436-8766a673-1fc4-4bd3-a3fe-4ffc1994d679.png"> <img width="150" alt="Снимок экрана 2022-05-23 в 23 21 01" src="https://user-images.githubusercontent.com/97699156/169899593-1aafaf4c-c187-4765-998c-914d4535e44f.png"> <img width="150" alt="Снимок экрана 2022-05-23 в 23 22 33" src="https://user-images.githubusercontent.com/97699156/169899784-08be43fe-38c9-42b5-91be-56736ea19e59.png">

## Summary
The application includes several view controllers: the login and registration screen, the book screen of all users, the screens of favorite books and books of this user, the detail screen of a book, and the addition and editing of a book. The server part based on Firebase.

## Login
Users must register and log in before they can access the main part of the application.

<img width="150" alt="Снимок экрана 2022-05-23 в 23 24 13" src="https://user-images.githubusercontent.com/97699156/169900038-fec5e95f-6e46-4a1e-8ffd-e87123f1c4eb.png">

## Main Views: Books, My books, Favorites
TabBar is used to navigate between main views

<img width="150" alt="Снимок экрана 2022-05-24 в 20 59 53" src="https://user-images.githubusercontent.com/97699156/170101989-73b9e26d-a0dc-480b-a7bc-a5badb629a39.png">


For these screens, UIViewControllers is used. The list of books is presented in the form of a table using TableView and a custom cell, which is placed in a separate xib file.

<img width="350" alt="Снимок экрана 2022-05-22 в 13 41 20" src="https://user-images.githubusercontent.com/97699156/169893388-cd61a740-1107-4e44-9dcb-db3456268851.png"> <img width="350" alt="Снимок экрана 2022-05-22 в 13 41 48" src="https://user-images.githubusercontent.com/97699156/169893452-f840eb6e-94ad-422f-883f-dd77bf9a4540.png">

## Add and edit book


<img width="150" alt="Снимок экрана 2022-05-24 в 20 34 18" src="https://user-images.githubusercontent.com/97699156/170097557-6029d8f5-bcfc-4196-ab2d-6607467fd1cd.png"> <img width="150" alt="Снимок экрана 2022-05-24 в 20 34 34" src="https://user-images.githubusercontent.com/97699156/170097570-8f1d3519-06b8-4bbb-a83e-d4167ef3fc40.png"> <img width="150" alt="Снимок экрана 2022-05-24 в 20 34 04" src="https://user-images.githubusercontent.com/97699156/170097595-6717a7f9-35c1-4b3e-ac22-c20a1ee3941a.png">


## Backend
### Authentication
Firebase Authentication is used for authorization.

Use Email/Password authentication to you can register and log users in.

<img width="550" alt="Снимок экрана 2022-05-22 в 13 06 24" src="https://user-images.githubusercontent.com/97699156/170098738-c81326ed-60b9-4cc1-9153-e3ea61fe98ab.png">

### Database
Firebase Realtime Database is used to store book data.

<img width="250" alt="Снимок экрана 2022-05-22 в 13 36 05" src="https://user-images.githubusercontent.com/97699156/170098320-fb11b1b5-25ea-40b4-85c8-f21d728e9401.png"> <img width="550" alt="Снимок экрана 2022-05-22 в 13 37 18" src="https://user-images.githubusercontent.com/97699156/170098345-e33f8ddf-0f82-4b13-9593-137af35a56c2.png">

### Storage
Firebase Storage is used to store images.

The file structure of the storage is illustrated here:

<img width="550" alt="Снимок экрана 2022-05-22 в 13 39 24" src="https://user-images.githubusercontent.com/97699156/170099564-0808f575-0c60-41c1-8389-be4ade1411d2.png">

