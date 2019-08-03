# Abstract_Pinball_Bouncing

# What is it?
 This project is meant to be an interactive experience that incorporates many different forms of art that were covered in class. The forms  included are generative art, algorithms, collage, musique concrete, programming, glitch art and simulation.

# Inspiration
 As people with coding background, we wanted to use Processing to create a piece that could incorporate a lot of different art concepts we learned in class this semester. 
 We went through a lot of ideas that related to each topic individually, and then combined them into one large project

# Technical Aspects
 The control panel is filled with multiple button toggles and sliders. We made classes that displayed the button and allowed us to check when a button was pressed to activate a different effect. The ball was also a class of its own so that we could handle collisions and modify the aspects such as speed, size and color for many different ball combinations.

# Ball Bouncing and Collision Detection
 The key component of the project was the addition of the moving ball. The ball’s position is constantly updated to make the ball appear to be moving. Collision detection is based by looping through all the obstacles continuously. 
Based on detection, the ball changes direction to make it appear like it’s bouncing. Also makes sound.

# Sound effect:
  1. Import the minim library
  2. Make an array of AudioPlayer
  3. Load the sound files and add it to AudioPlayer array
  4. Play the sound when the collision happen
  5. One unique sound track in every side of four walls
  6. Randomly select sounds for hitting the obstacles.
  7. Custom sound from users 
