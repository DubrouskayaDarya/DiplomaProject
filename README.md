# DiplomaProject
# Mobile ios application BooksAD
## General information about the application
The BooksAD app is an app for posting book ads
<img width="296" alt="Снимок экрана 2022-05-23 в 23 19 42" src="https://user-images.githubusercontent.com/97699156/169899436-8766a673-1fc4-4bd3-a3fe-4ffc1994d679.png"> <img width="296" alt="Снимок экрана 2022-05-23 в 23 21 01" src="https://user-images.githubusercontent.com/97699156/169899593-1aafaf4c-c187-4765-998c-914d4535e44f.png"> <img width="296" alt="Снимок экрана 2022-05-23 в 23 22 33" src="https://user-images.githubusercontent.com/97699156/169899784-08be43fe-38c9-42b5-91be-56736ea19e59.png">
## Summary
The application includes several view controllers: the login and registration screen, the book screen of all users, the screens of favorite books and books of this user, the detail screen of a book, and the addition and editing of a book. The server part will be powered by Firebase.
## Login
Users must register and log in before they can access the main part of the application.
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-05-22 at 12 29 26](https://user-images.githubusercontent.com/97699156/169892276-648fa4f5-5afe-49f7-a908-fb6babd2dcd1.png)
## Main Views: Books, My books, Favorites
For these screens, UIViewControllers is used. The list of books is presented in the form of a table using TableView and a custom cell, which is placed in a separate xib file.
<img width="850" alt="Снимок экрана 2022-05-22 в 13 41 20" src="https://user-images.githubusercontent.com/97699156/169893388-cd61a740-1107-4e44-9dcb-db3456268851.png">
<img width="565" alt="Снимок экрана 2022-05-22 в 13 41 48" src="https://user-images.githubusercontent.com/97699156/169893452-f840eb6e-94ad-422f-883f-dd77bf9a4540.png">
