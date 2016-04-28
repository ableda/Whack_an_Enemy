1. Overview
-------------

This manual is intended to serve asa reference for Developers as they build and expand on the "Whack an Enemy!" app. 



2. "Whack an Enemy!"
-----------------------

Whack an Enemy is a simple game based on Whack a Mole. In the game, the user can play in two different game modes and compete to get the highest score. The user can also change the pictures used as enemies and friends in the game. If the user hits the enemy they gain one point. If the user hits a friend they lose five points.


3. How is the Game Built
----------------------------

The game was built using Swift. There are different files for each screen that can appear and functions in each file designating the method to move from one screen to another by using different buttons on the screen. 


4. How to Build the App
------------------------

We built the game using the libraries in Swift. The functions in the different scenes create different game modes allowing the user's touches on the screen to get points and make changes. 


4.1 Language, Libraries, Platform, and APIs used
-----------------------------------------------

The game was built using Swift. In Swift the UIKit, GampeplayKit, and SpriteKit were used to make the functions work as well as the buttons and images in the game. These libraries and the language allow us to use the information in the most efficient way and keep track of movement to create the game. They also allow the information to be stored and used again when the app is closed and reopened and after every game is finished. The information from previous games is used to keep track of new high scores.


4.2 Files Roadmap
-------------------

Opening the app starts with the GameScene as the main menu. This screen shows the options to change the character images for the enemy and the friend, start a game in Classic Mode, start a game in Chaos Mode, or view the top five High Scores. 

Clicking on the Change Picture button brings the user to the pictureScene. This screen allows the user to click on the enemy or the friend to change the picture by accessing the camera to take a picture.

Clicking the Classic Mode button brings the user to tha playScene in which the game mode brings up one enemy or friend every second and the user has to tap on the enemy to gain one point. If the friend is hit the user loses five points. At the end of the round, the user is prompted to click on High Scores or the Home Button. The Home button brings the user back to GameScene and the High Scores button brings the user to scoreScene.

Clicking the Chaos Mode button brings the user to tha chaosScene in which the game mode brings up many enemies or friends every second and the user has to tap on the enemy to gain one point. If the friend is hit the user loses five points. At the end of the round, the user is prompted to click on High Scores or the Home Button. The Home button brings the user back to GameScene and the High Scores button brings the user to scoreScene.

The High Score button brings the user to a list of the top 5 scores. The user can then return to the main menu from here.

At the end of either game mode, the user can click on the Home button to go back to the main menu or the High Score button and go to scoreScene.


4.3 File Structure
--------------------

4.3.1 WhackSlot.swift
----------------------

This file makes the different images pop up in the nodes to create the game. This file also has the function which recognizes when an enemy or friend is hit.


4.3.2 GameScene.swift
------------------------

This file consists of the main frame work of the main menu. In this screen you can click on the different buttons to advance to the next screens. It uses functions to accomplish this.


4.3.3 playScene.swift
------------------------

This file contains the main code for the classic mode of the game. In this file are all the functions to keep track of score in a game and this calls the WhackSlot file to make the game work. This file also contains some frame work for the game to run.


4.3.4 scoreScene.swift
-----------------------

This file contains the functions that generate the high score list. The functions in this file store the scores of previous games and return the top five scores for each game mode in their respective columns.


4.3.5 chaosScene.swift
------------------------

This file contains the main code for the chaos mode of the game. In this file are all the functions to keep track of score in a game and this calls the WhackSlot file to make the game work. This file also contains some frame work for the game to run.


4.3.6 pictureScene.swift
---------------------------

This file contains the functions used when the Change Picture button is pressed on the main screen. It allows the use to take a picture using the camera and replace the enemny or friend with the picture. This file also modifies the picture so that it is in an oval shape.

