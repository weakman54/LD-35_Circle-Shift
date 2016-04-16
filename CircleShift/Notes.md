Dev notes
=========
For simple Tetris clone
These are notes for thought flow, so there is only minimal effort to keep this tidy and correct, do not expect any great clarity or flow in the text.

Mechanics
---------
* Tetronimoes fall from the top and down, one at a time.
    * Implement Tetros, implement falling mechanism
* If they collide with the bottom or another Tetronimo, they freeze in place at that point
    * Check collisions and make a "freezing" mechanism
* If the frozen Tetros make a horizontal line that covers the entire width of the 
play-area, those Tetros will dissapear
    * Check "Frozen" Tetros if they are making a line after each "touchdown" of a new Tetro
    * Handle Tetros falling down to fill the gap, and subsequent new rows that might have appeared

Aesthetics
----------
* Have a more "gritty" feel on the game, heavy falls, vibrating effects, grinding metal.
* Add to that a bit of neon coloring for extra "flavor"
* Add "heavy" soundeffects
* Make some industrial influenced music

Story
-----
Not sure if there will be anything for story at the moment

Fourth Category?
-----------------
I'm pretty sure there is a fourth category, can't figure it out atm though...
Yeah, technology, which is straightforward: Löve 2d engine =P


Programming stuff
-----------------
* Make a grid for the play area
* Add an indicator for the next Tetro
* Add a score indicator
* Figure out a good way to calculate score and speed (how does the original game do it?)

* Grid of Blocks
* Block is either falling or frozen
* Tetro holds references to falling blocks, and handles rotations

* Gameflow goes in "rounds", each round, things happen:
    * If there is a Tetro falling/rotating, do that action (if Tetro has a reference)
        * If the Tetro tries to fall, but can't, freeze it
    * ElseIf there is no current Tetro falling, check for rows
        * If row, remove it and do all the stuff related
            * Set score
            * Set all blocks above to fill in the space
    * Else spawn new Tetro
        * Update "next" Tetro window
