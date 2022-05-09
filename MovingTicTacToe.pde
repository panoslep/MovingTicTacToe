/**
 * Moving Tic Tac Toe
 * Panos Lepipas
 *
 * A game similar to tic tac toe. Players have 3 pawns each and put them
 * on a 3 by 3 board. After finishing with the position players can relocate
 * their pawns one at a time. The winner is the first who has his pawns
 * positioned on a vertical, horizontal or diagonal line.
 */
 
 //Check for improvement:  
 // Stamata to meta ti niki, Vres orizontia sximata, Na min pairnei me sursimo stin arxi,
 //Moving on Curves
 //Mouse Functions
 //LoadDisplayShape: for better pawns and backgr image
 
 /** The cycles-positions are named as
 *         2  9  4
 *         7  5  3
 *         6  1  8
 * So the winner must achieve a sum of 15
 */
 
 boolean rest=false;
 boolean insert=false;
 boolean bover = false;
 boolean locked = false;
 boolean firstPhase=true; //stil possitioning pawns
 int pawnsOnBoard=0;
 int[] position=new int[2];
 int player1=0;
 int player2=0;
 int[][] mat=new int[3][3];
 int[][] taken=new int[3][3];     //0 for empty, 1 or 2 for player1 or player 2 
 
 int colP1=53;     //colour of player1's pawns
 int colP2=3;
 int winner=1;
 int lastPlayed=2;
 int[] temp=new int[2];
 boolean moveit=false;
 boolean setit=false;
 boolean go=false;

 void setup() 
{
  frameRate(30);
  size(600, 600);
  background(10000);
     
     //text options
     textSize(60);
     
     textAlign(CENTER, CENTER);

  
  for (int i=0; i<3; i++)
  {
     
     //draw lines of acceptable motion
         rect(i*200+90,0*200+90, 20 , 360);
         rect(0*200+90,i*200+90, 360 , 20);

    for (int j=0; j<3; j++)
    {
        taken[i][j]=0;
        
    }
  }
  
//            rectMode(CENTER);
//            fill(23,23,23);
//           // rotate(0.5*cos(45));
//            for (int i=0; i<10; i++){
//              rotate(i);
//              fill(23+i*5,23+i,23+i);
//              translate(width/2, height/2);
//              rect(0,0, 300 , 20);
//            }
  
  smooth();
  
  mat[0][0]=2;
  mat[0][1]=9;
  mat[0][2]=4;
  mat[1][0]=7;
  mat[1][1]=5;
  mat[1][2]=3;
  mat[2][0]=6;
  mat[2][1]=1;
  mat[2][2]=8;
//  rectMode(RADIUS);    //ti kanei auto?
}


void draw() 
{
          bover=false;
    background(10000);
    
    fill(255);
    stroke(255);
    line(90,90,490,490);
    line(490,90,90,490);
    for (int i=0; i<3; i++)
  {
     
     //draw lines of acceptable motion
         fill(255);
         rect(i*200+90,0*200+90, 20 , 360);
         rect(0*200+90,i*200+90, 360 , 20);
  }

  //restart button
         fill(255);
         if ((mouseX>20)&&(mouseX<40)&&(mouseY>10)&&(mouseY<30))
         {
           fill(15,15,15);
           rest=true;
         }
         else
         {
           rest=false;
         }
         rect(20,10,20,20);
         textSize(18);
         fill(10);
         text("R",30,20);
         textSize(60);
         
         

  //draw the position cycles
  for (int i=0; i<3; i++)
  {
    for (int j=0; j<3; j++)
    {
      // Test if the cursor is over the box 
      if (((mouseX-(i*200+100))*(mouseX-(i*200+100))+(mouseY-(j*200+100))*(mouseY-(j*200+100)) < 60*60)&&(firstPhase)
      &&(taken[i][j]==0)) { 
        stroke(255); 
        fill(153);
        ellipse(i*200+100, j*200+100, 120 , 120);   
        bover=true;
        position[0]=i;
        position[1]=j;
       
       // Insert pawns
        if (insert)
        {
          if (pawnsOnBoard%2==1)
          {
            taken[i][j]=1;
            noStroke();
            fill(colP1);
            ellipse(i*200+100, j*200+100, 60 , 60);
          }
          else
          {
            taken[i][j]=2;
            fill(colP2,12,60);
            ellipse(i*200+100, j*200+100, 60 , 60);
          }
        }
      }
      
      //mouse outside cycle
      else{
          noStroke();
          fill(255);
          ellipse(i*200+100, j*200+100, 120 , 120);
             
             //who plays
             textSize(25);
             if (lastPlayed==2){
                fill(90,6,9);
                text("1", 200,20);
             }
             else{
                fill(colP2,12,60);
                text("2", 200,20);
             }
                text("Player",150,20);
             
             //keep the taken cycles 
             if (taken[i][j]==1)
             {
               fill(90,6,9);
               ellipse(i*200+100, j*200+100, 70 , 70);
             }
             if (taken[i][j]==2)
             {
               fill(colP2,12,60);
               ellipse(i*200+100,j*200+100, 70 , 70); 
             }    
             
             //moving cycle
             if ((moveit))
             {
               if (lastPlayed==2)
               {
                    fill(90,6,9);
                    ellipse(mouseX, mouseY, 70 , 70);
               }
               else
               {
                    fill(colP2,12,60);    
                    ellipse(mouseX, mouseY, 70 , 70);
               }
             }
      }
             
             
          
          if (checkVictory(player1))
            {
             fill(0); 
             rect(40,260,530,100);
             fill(204, 204, 0);  
             text("PLAYER 1 WINS",width/2,height/2);
            }
          if (checkVictory(player2))
            {
             fill(0); 
             rect(40,260,530,100);
             fill(204, 204, 0);  
             text("PLAYER 2 WINS",width/2,height/2);
            }
          
        
      }
    }
        //check if all pawns are on board
        if (pawnsOnBoard==6){
          firstPhase=false;
        }
  }




void mouseReleased() {
  locked = false;
  insert=false;
  
  //restart if button pressed
  if (rest)
      restart();
      
      
  if (moveit)
  {   
      go=false;
      moveit=false;
      for (int i=0; i<3; i++){
          for(int j=0; j<3; j++){ 
           
            //check if it touches as cycle and if the movement is allowed
            if (((mouseX-(i*200+100))*(mouseX-(i*200+100))+(mouseY-(j*200+100))*(mouseY-(j*200+100)) < ((35+60)*(35+60)))
            &&(taken[i][j]==0)&&(abs(i-temp[0])<2)&&(abs(j-temp[1])<2)&&((temp[0]!=i)||(temp[1]!=j))
            &&(((temp[0]+temp[1])%2!=1)||((i+j)%2!=1)))  //last one is to exclude diag moves
            {
               lastPlayed=lastPlayed%2+1;     //change lastplayed status
              
               taken[i][j]=lastPlayed;
               if (lastPlayed==1)
               {
                   player1+=(mat[i][j]-mat[temp[0]][temp[1]]);
               }
               else
               {
                   player2+=(mat[i][j]-mat[temp[0]][temp[1]]);
               }
               temp[0]=i;
               temp[1]=j;
               moveit=false;
               go=true;       //this is not accually necessary, to be removed
            }
          }
      }
                       if (!go)
                       {
                       taken[temp[0]][temp[1]]=lastPlayed%2+1;
                       moveit=false;
                       }
       
      }    
                   
      }  




void mousePressed() { 
  locked=true;
  
  if ((bover)&&(firstPhase)) { 
        insert=true;
        lastPlayed=lastPlayed%2+1;
        pawnsOnBoard++;
        
        //add pawns to players
        if (pawnsOnBoard%2==1)
          player1+=mat[position[0]][position[1]];
        else
          player2+=mat[position[0]][position[1]];
          
        bover=false;
  }
 
     //After phase one; Check if pawn picked 
      if (!firstPhase)
      {
        for (int i=0; i<3; i++){
          for(int j=0; j<3; j++){
            if ((mouseX-(i*200+100))*(mouseX-(i*200+100))+(mouseY-(j*200+100))*(mouseY-(j*200+100)) < 35*35)
               if (taken[i][j]==lastPlayed%2+1)
               {
                  motion(i,j);
               }
          }
        }
      }
  
}


void motion(int i, int j)
{
  
     taken[i][j]=0;
     temp[0]=i;
     temp[1]=j;
     
  if (!firstPhase)
     moveit=true;  
     
}

boolean checkVictory(int sum)
{
  if ((sum==15)&&(!firstPhase))
  {
    return true;
  }
  else
  {
    return false;
  }
}

void restart()
{
   insert=false;
  bover = false;
  locked = false;
  firstPhase=true; //stil possitioning pawns
  pawnsOnBoard=0;
  player1=0;
  player2=0;
 
 
  winner=1;
  lastPlayed=2;
  moveit=false;
  setit=false;
  go=false;

 setup(); 
  
  
}
