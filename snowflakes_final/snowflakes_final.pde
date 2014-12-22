/*

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

// Setup all your variables.
// Variable and value for the size of the flake.
float size = 70;
// Variable and value for the detail of each branch.
float detail = 5;
// Variable and value for the number of branch levels.
int levels = 5;
int branches;

// Setting up the code.
void setup() {
  // Defining the size of the canvas.
  size(431, 309);
  // Makes the background color yellow on setup.
  background(255, 241, 0);
  // Take a stroke off of everything.
  noStroke();
}

// Looping through all the code and draw a new snowflake each time.
void draw() {
  // Makes the background color yellow every frame
  // and covers up the previous design.
  background(255, 241, 0);
  // Makes all the snowflakes white.
  fill(255);
  // Creating a random whole number (integer) value for 
  // the branches on the snowflake between 6 and 10.
  branches = int(random(6, 10));
  // Call the snowflake function and pass in values.
  // We pass in the x location, y location, radius, detail of the flake, 
  // number of branches and levels of flakes.
  snowS(width/2, height/2, size, detail, branches, levels);
  // Add a 500 millisecond delay to see the flake longer.
  delay(500);
}

// Set up function for the snowflake
void snowS(float X1, float Y1, float S, float D, int branches, int levels) {
  // Setting up the arrays for the snowflake 
  int[] tabbranches = new int[levels];
  float[] tabS = new float[levels];
  float[] tabD = new float[levels];
  float[] tabR = new float[levels];
  // Loop threw all the branches and add random branches based 
  // on the levels number.
  for (int i = levels-1; i >= 0; i--) {
    // Randomizing the first values in the arrays
    if(i < levels-1) {
      // Random whole values for the number of branches.
      tabbranches[i] = int(random(6)+2);
      // Creating a random value for the size and detail thats slightly 
      // larger than the previous value in the array. (i+1)
      tabS[i] = tabS[i+1]*random(0.5, 0.7);
      tabD[i] = tabD[i+1]*random(0.4, 0.5);
      // Random values for the radius
      tabR[i] = random(HALF_PI, PI-HALF_PI/2);
    } else {
      // Setting the last value in the array
      tabbranches[i] = branches;      
      tabS[i] = S;
      tabD[i] = D;
      tabR[i] = 0;
    }
  }
  // Add all the values in the arrays above to the snowflake draw function.
  snowD(X1, Y1, tabS, tabD, tabR, tabbranches, levels);
}

// Draw the snowflake using this function
void snowD(float X1, float Y1, float S[], float D[], float R[], int branches[], int levels) {
  // Reduce the level depth each frame by one to avoid any errors 
  // with push and popMatrix.
  levels = levels - 1;
  // If the levels are greater than 0, run this code.
  if (levels > 0) {
    // Define the rotation value to be used below.
    float rot = TWO_PI/branches[levels];
    // Draw the snowflake on the screen.
    pushMatrix();
    // Translate the snowflake to the right x and y position,
    // in this case the center of the screen.
    translate(X1, Y1);
    // Loop threw the code to draw each branch.
    for (int i = 0; i < branches[levels]; i++) {
      // Draw the branches of the snowflake.
      rect(0, -D[levels]/2, S[levels], D[levels]);
      // Call the snowflake draw function repeatedly to draw each branch.
      snowD(S[levels], 0, S, D, R, branches, levels);
      // Rotate each branch of the snowflake.
      rotate(rot);
    }
    popMatrix();
  }
}

