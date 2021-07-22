#   ECE564_HW 
This is the project you will use for all of your ECE564 homework assignments. You need to download to your computer, add your code, and then add a repo under your own ID with this name ("ECE564_HW"). It is important that you use the same project name.  
This should work fine for HW1 - HW4.  If you decide to use SwiftUI for your user interface, you can recreate with a new project (keep the name) or follow something like this - https://stackoverflow.com/questions/56529488/is-there-any-way-to-use-storyboard-and-swiftui-in-same-ios-xcode-project

Any notes, additional functions, comments you want to share with the TA and I before grading please put in this file in the correspondiing section below.  Part of the grading is anything you did above and beyond the requirements, so make sure that is included here in the README.

## HW1
This assignment was turned in late by ~12 hours. Extra functionality includes: larger data structure, integrated color scheme, generalized location for controlling colors, generalized location for controlling layout attributes, generic string generation for description at the bottom, enumerations utilized for gender (including nonbinary language). No hobbies and no languages are supported options for filling out a person's information. Functionality for a clear button is also supported

## HW2
Extra functionality includes:
* Pictures assigned to each person preregistered in the database, default avatar also included
* Included netID field and associated (calculated) email box
* Updated description text to accommodate email
* Error checking to ensure both first and last names are provided
* Project was split between the ViewController and DataModel
* A custom colors enumeration was attempted but ultimately not included for this submission
* Names no longer revert upon unsuccessful search query

## HW3
Extra functionality includes:
* Reset button that resets the cache and locally held data for testing
* Email field that autofills if no email is given and netID is present

## HW4
Extra functionality includes:
* Refactored colors to be an extension of UIColor for quick access and change
* Beginning of large refactor to more delegated data model "ModelPerson" is in progress on refactor branch
* CodableDukePerson allows for clean split between the functional DukePerson class and the data-driven CodableDukePerson with helper functions
* Error checking that should be able to display any given DukePerson JSON and not crash the app

## HW5
The functionality is as follows:
* Refactored the data structure so that the code is a lot cleaner (DataBase) and static methods cover all the needed functions
* TableView is implemented with the proper cells
* A cache clear button has been provided (the rewind icon) with an additional alert
* An alert has been added for when the download is complete
* When accessing someone's information, one may only edit the fields after selecting the disappearing "Edit" button
* The user interface has been cleaned up to reflect the change in delegation for tasks
* JSON and HTTPS code were arranged such that moving them to the new implementation was quite painless
* DataBase class is formatted to be able to quickly interface with the CodableDukePerson static class as well
* Helper class is used to significantly cut down on the size and responsibility of the Information View Controller

## HW6
The functionality is as follows:
* Swipe funcitonality has been added, swipe to the right to see the options
* Flip functionality has been added that features the duke person's image and text
* Click the reload button to flip back
* An app icon has been designed and implemented, including on the startup sequence
* The only warnings at runtime are concerning layout constraints which have not yet been covered in this class

## HW7
The functionality is as follows:
* The frisbee is a gif assembled by pictures that I designed in Google Draw of the standard competition frisbee
* The grass lines and cone are subclassed drawn items, each using different functions of the UIBezierLine (grass lines are the line by line, cone uses lines and rounded corner rectangle)
* The grass lines and cone are also animated both using the UIView.animate function
* Animation used both the repeat and curveLinear tags
* The background is a fully vector generated image (including the cloud in the sky)
* The colors for the grass and sky have been added to the custom library of colors
* The attributed text uses the font, size, and text attributes
