float xPos;
float yPos;

float vx;
float vy;

float radius;

boolean inPlay;

float pegRadius;
float peg1X, peg1Y;
float peg2X, peg2Y;
float peg3X, peg3Y;


boolean inCircle;
boolean a, b, c;

int score = 0;
int finalScore;

float textPosX = 70;
float textPosY = 70;

boolean invalid;

void setup()

{
  size(500, 500);
  radius = 15;
  pegRadius = 20;

  peg1X = 250;
  peg1Y = 200;
  peg2X = 70;
  peg2Y = height - 24;
  peg3X = width - 24;
  peg3Y = 70;

  background(255);
  textSize(48);

  xPos = width - radius;
  yPos = height - radius;

  inPlay = false;
}

void draw()
{
  background(#000000);

  drawPeg(peg1X, peg1Y);
  drawPeg(peg2X, peg2Y);
  drawPeg(peg3X, peg3Y);
  
  if (invalid)
  {
    textSize(50);
    fill(#E5B410);
    text("INVALID PEG POSITION", width - width + 10, height / 2);
    textSize(40);
    strokeWeight(5);
    text("Game will end if placed there", width - width + 10, height / 2 + 50);
  }

  if (inPlay)
  {
    moveBall();

    drawBall();

    rebound();

    checkForCollision(peg1X, peg1Y);
    checkForCollision(peg2X, peg2Y);
    checkForCollision(peg3X, peg3Y);
  } 
  else
  {
    drawBall();
    drawAimingLine();
  }
}

void keyPressed()
{
  if (inPlay)
  {
  } else
  {
    if (key== ' ')
    {
      vx = (mouseX - xPos) / 100;
      vy = (mouseY - yPos) / 100;
      inPlay = true;
    }
  }
}

void mousePressed() {

  if (inPlay)
  {
  } 
  else
  {
    checkCircle(peg1X, peg1Y);

    if (inCircle == true)
    {
      a = true;
    }

    checkCircle(peg2X, peg2Y);

    if (inCircle == true)
    {
      b = true;
    }

    checkCircle(peg3X, peg3Y);

    if (inCircle == true)
    {
      c = true;
    }
  }
}

void mouseDragged()
{
  if (a==true)
  {
    peg1X = mouseX;
    peg1Y = mouseY;

    if (dist(mouseX, mouseY, peg2X, peg2Y) < pegRadius + pegRadius ||  dist(mouseX, mouseY, peg3X, peg3Y) < pegRadius + pegRadius)
    {
      invalid = true;
    }
    else
    {
     invalid = false;
    }
  }

  if (b==true)
  {
    peg2X = mouseX;
    peg2Y = mouseY;
    
    if (dist(mouseX, mouseY, peg1X, peg1Y) < pegRadius + pegRadius ||  dist(mouseX, mouseY, peg3X, peg3Y) < pegRadius + pegRadius)
    {
      invalid = true;
    }
    else
    {
     invalid = false;
    }
  }

  if (c==true)
  {
    peg3X = mouseX;
    peg3Y = mouseY;
    
    if (dist(mouseX, mouseY, peg2X, peg2Y) < pegRadius + pegRadius ||  dist(mouseX, mouseY, peg1X, peg1Y) < pegRadius + pegRadius)
    {
      invalid = true;
    }
    else
    {
     invalid = false;
    }
  }
}

void mouseReleased()
{
  
  if (invalid)
  {
    textSize(50);
    fill(#DB0F0F);
    text("INVALID PEG POSITION", width - width + 10, height / 2 );
    fill(#000000);   
    textSize(40);
    strokeWeight(5);
    text("Game will end if placed there", width - width + 10, height / 2 + 50);
    fill(#DB0F0F);
    textSize(50);
    text("Game Ended, Run Again", width - width + 10, height / 2 + 50);
    frameRate (0);
  }
  
  a = false;
  b = false;
  c = false;
}



void drawPeg(float x, float y)
{
  fill(255, 0, 0);
  stroke(0);
  
  circle(constrain(x, 20, width-20), constrain(y, 20, height-20), 2 * pegRadius);
}

void moveBall()
{
  xPos = xPos + vx;
  yPos = yPos + vy;
}

void drawBall()
{
  noStroke();
  fill(0, 0, 255);
  circle(xPos, yPos, 2 * radius);
}

void rebound()
{

  if (xPos - radius < 0 || xPos + radius > width)
  {
    vx = -vx;
    score = score + 1;
  }
  if (yPos - radius < 0 || yPos + radius > height)
  {
    vy = -vy;
    score = score + 1;
  }
}

void checkForCollision(float x, float y)
{
  if (dist(xPos, yPos, x, y) < radius + pegRadius)
  {
    fill(#FAFAFA);
    rotate(radians(30));
    textSize(100);
    text("GAME OVER!", textPosX, textPosY);
    textSize(70);
    text("Your score was " + score, textPosX + 30, textPosY + 100);
    frameRate(0);
  }
}

void drawAimingLine()
{
  stroke(#FAFAFA);
  line(xPos, yPos, mouseX, mouseY);
}

void checkCircle(float x, float y)
{
  if (dist(mouseX, mouseY, x, y)<radius)
  {
    inCircle = true;
  } else
  {
    inCircle = false;
  }
}
