
float eyeX, eyeY, eyeZ;
float seeX, seeY, seeZ;

float traceX, traceY, traceZ;
float traceW, traceH, traceL;

float wallX, wallY;

int d = 100;
float Xcomp, Zcomp, Ycomp;
float angle = 0;
float angleY = 0;


float handLight;
float sensitivity = 10;
float cameraDistance = 2000;
float moveSpeed = 200;

boolean cameraLeft, cameraRight, cameraFront, cameraBack;

float curX, curY, curZ;
boolean col;

boolean doorActive;
boolean doorAction;
boolean doorOpen;
int doorActionTime;

boolean closelyActive;
boolean closelyAction;


door d1 = new door(-300, -55, 50, 5, 80, 50 ,"-x" ,10 ,0);      //float x, float y, float z, float w, float h, float l, String direction, float tx, float tz)
bed b1 = new bed(360, 60, 290, 260, 10, 100);
desk dk1 = new desk(360, 0, -230) ;
  
long startTime;
long endTime;
long ltime;

boolean haveKey = false;

void setup(){
  //fullScreen(P3D);
  size(1920,1080,P3D);

  //noLights();
  eyeX = 0;
  eyeY = -50;
  eyeZ = d;
  
  seeX = 0;
  seeY = 0;
  seeZ = 0.0;
  
  wallX = 50;
  wallY = 50;
  
  cameraLeft = false;
  cameraRight = false;
  cameraFront = false;
  cameraBack = false;
  
  curX = eyeX;
  curY = eyeY;
  curZ = eyeZ;
  col = false;
  doorActive = false;
  doorAction = false;
  doorOpen = false;
  
  handLight = 0;
  
  traceW = 20;
  traceH = 20;
  traceL = 100;
  
  d1.doorSetup();
  
}

void draw(){
  //noLights();
  noCursor();
  background(0);
  noStroke();
  ambientLight(10, 10, 10);
  

  //traceX = eyeX + traceW/3;
  //traceY = eyeY + traceH;
  //traceZ = eyeZ - traceL - 100;
 
  cameraUpdate();
 
  //pushMatrix();
  //rotateY(map(mouseX, 0, width, 0, 360));
  //popMatrix();
  //camera(eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 
       //0.0, 1.0, 0.0);
       
  //beginCamera();
  //camera();
  //camera(eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.0, 1.0, 0.0);
  //translate(width/2, height/2);
  //rotateY(map(mouseX, 0, width, 0, 10));
  //rotateY(radians(ang));
  //translate(-width/2, -height/2);
  //translate(-width/2, -height/2);
       
  if(cameraLeft){
    eyeX += Zcomp/moveSpeed;
    seeX += Zcomp/moveSpeed;
    eyeZ -= Xcomp/moveSpeed;
    seeZ -= Xcomp/moveSpeed;
  }
  if(cameraRight){
    eyeX -= Zcomp/moveSpeed;
    seeX -= Zcomp/moveSpeed;
    eyeZ += Xcomp/moveSpeed;
    seeZ += Xcomp/moveSpeed;
  }
  if(cameraFront){
    eyeZ += Zcomp/moveSpeed;
    seeZ += Zcomp/moveSpeed;
    eyeX += Xcomp/moveSpeed;
    seeX += Xcomp/moveSpeed;
  }
  if(cameraBack){
    eyeZ -= Zcomp/moveSpeed;
    seeZ -= Zcomp/moveSpeed;
    eyeX -= Xcomp/moveSpeed;
    seeX -= Xcomp/moveSpeed;
  }
  
  
  pointLight(150, 150, 150, 0, -100, 0);
  //pointLight(20, 20, 20, 0, -100, 0);
  //spotLight(0, 255, 0, 0, -150, 0, 0, 100, 0, 0.3, 1);
  camera(eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.0, 1.0, 0.0);    
  spotLight(handLight, handLight, handLight, eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.4, 5);
  
  println("eyeX : "+eyeX);
  println("eyeY : "+eyeY);
  println("eyeZ : "+eyeZ);
  println("seeX : "+seeX);
  println("seeY : "+seeY);
  println("seeZ : "+seeZ);
  println("----------------------");
  
  
  d1.update();
  d1.collision();
  d1.Action();
  
  b1.update();
  b1.collision();
  b1.Action();
  
  dk1.update();
 
  boxCasting();
 
  /*pushMatrix();
  noStroke();
  translate(200,0);
  sphere(50);
  popMatrix();*/
  
  
  
  startTime = millis();
  bottom();
  top();
  wall_z();
  wallz();
  wall_x();
  wallx();
  endTime = millis();
  ltime = endTime - startTime;
  println("wall TIME : " + ltime + "(ms)");
  
  collision();
  
}


void cameraUpdate(){              //------------------------------------------------------ cameraUpdate ----------------------------------------------------------
  
  Xcomp = seeX - eyeX;
  Zcomp = seeZ - eyeZ;
  Ycomp = seeY - eyeY;
  
  angle = correctAngle(Xcomp, Zcomp);
  
  float cameraRotateX = (pmouseX - mouseX)*1.2;
  if(cameraRotateX == 0){
    if(mouseX <= 10){
      cameraRotateX = 100;
    }else if(mouseX >= width-10){
      cameraRotateX = -100;
    }
  }
  angle+= -cameraRotateX/(sensitivity*3);
  
  if(angle < 0)
    angle += 360;
  else if (angle >= 360)
    angle -= 360;
  
  float newXComp = cameraDistance * sin(radians(angle));
  float newZComp = cameraDistance * cos(radians(angle));
  
  seeX = newXComp + eyeX;
  seeZ = -newZComp + eyeZ;
  
  
  angleY = atan(Ycomp/1000);
  
  float cameraRotateY = (pmouseY - mouseY)*1.5;
  if(cameraRotateY == 0){
    if(mouseY <= 10){
      cameraRotateY = 60;
    }else if(mouseY >= height-10){
      cameraRotateY = -60;
    }
  }
  
  
  seeY+= -cameraRotateY/(sensitivity/10);
}

public float correctAngle(float xc, float zc){
  float newAngle = -degrees(atan(xc/zc));
  if (Xcomp > 0 && Zcomp > 0)
    newAngle = (90 + newAngle)+90;
  else if (Xcomp < 0 && Zcomp > 0)
    newAngle = newAngle + 180;
  else if (Xcomp < 0 && Zcomp < 0)
    newAngle = (90+ newAngle) + 270;
  return newAngle;
}



class door{                            //------------------------------------------------------ door ----------------------------------------------------------
  float doorX, doorY, doorZ;
  float doorW, doorH, doorL;
  
  String doorDirection;
  float textX, textZ;
  float colDistanceX, colDistanceZ;
  float textRotate;
  float doorRotate;
  
  door(float x, float y, float z, float w, float h, float l, String direction, float tx, float tz){
    doorX = x;
    doorY = y;
    doorZ = z;
    doorW = w;
    doorH = h;
    doorL = l;
    doorDirection = direction;
    textX = tx;
    textZ = tz;
  }
  
  void doorSetup(){
    switch(doorDirection){
      case "-x":
        colDistanceX = 130;
        colDistanceZ = 90;
        textRotate = 90;
        doorRotate = 0;
        break;
      case "x":
        colDistanceX = 130;
        colDistanceZ = 90;
        textRotate = 270;
        doorRotate = 180;
        break;
      case "z":
        colDistanceX = 90;
        colDistanceZ = 130;
        textRotate = 180;
        doorRotate = 90;
        break;
      case "-z":
        colDistanceX = 90;
        colDistanceZ = 130;
        textRotate = 0;
        doorRotate = 270;
        break;
    }
  }
  
  void update(){
    pushMatrix();
      translate(doorX, doorY, doorZ);
      //pushMatrix();
      translate(0, 0, doorZ/2);
      rotateY(radians(doorRotate));
      translate(0, 0, -doorZ/2);
      
      fill(100,50,50);
      box(doorW, doorH, doorL);
      
      translate(0, 0, -doorL);
      box(doorW, doorH, doorL);
      
      translate(0, doorH, 0);
      box(doorW, doorH, doorL);
      
      translate(0, 0, doorL);
      box(doorW, doorH, doorL);
      noFill();
    
      if(doorActive){
        pushMatrix();
          translate(textX, -doorH/2, textZ);
          rotateY(radians(textRotate));
          fill(0);
          text("press E", 0, 0, 0);
        popMatrix();
      }
    
    popMatrix();
  }
  
  void collision(){
    if(!doorOpen){
      println("doorX : "+doorX);
      println("doorY : "+doorY);
      println("doorZ : "+doorZ);
      /*if(col == false){
          curX = eyeX;
          curY = eyeY;
          curZ = eyeZ;
        }*/
        
      if(eyeX >= doorX - colDistanceX && eyeX < doorX + doorW/2 + colDistanceX
      //&& eyeY > doorY && eyeY < doorY + doorH*2
      && eyeZ >= doorZ - colDistanceZ && eyeZ < doorZ + doorL/2 + colDistanceZ){
        col = true;
        eyeX = curX;
        eyeZ = curZ;
        println("oops");
      }else{
        col = false;
      }
      
      if((traceX - traceL >= doorX + doorW || traceX < doorX)
      //&& (traceY > doorY + doorH*2 || traceY + traceH < doorY)
       ||(traceZ - traceW - 50 >= doorZ || traceZ <= doorZ - doorL -50)
      ){
        doorActive = false;
      }else{
        doorActive = true;
        println("trace");
      }
    }
  }
  
  void Action(){       
    if(doorAction){
      if(!haveKey){
        if(millis() - doorActionTime >= 1500){
          doorAction = false;
        }
        
        pushMatrix();
          translate(0, 0, 50);
          rotateX(-angleY);
          fill(0);
          text("No Key.", -20, 50, -100);
          noFill();
        popMatrix();
      }else{
        doorOpen = true;
        if(doorRotate <= 90){
          doorRotate += 2;
        }
      }
    }
  }
  
}

class bed{                  // ------------------------------------------------------------ bed ------------------------------------------------------
  float bedX, bedY, bedZ;
  float bedW, bedH, bedL;
  float closelyX, closelyY, closelyZ;
  float closelyH = 0;
  
  bed(float x, float y, float z, float w, float h, float l){
    bedX = x;
    bedY = y;
    bedZ = z;
    bedW = w;
    bedH = h;
    bedL = l;
  }
  
  void update(){
    println(closelyX +"  "+ closelyY +"  "+ closelyZ);
    pushMatrix();
      fill(0);
      
      translate(bedX, bedY, bedZ);
      pushMatrix();
        box(10,15,10);
        translate(0, 0, bedL);
        box(10,15,10);
        translate(-bedW, 0, 0);
        box(10,15,10);
        translate(0, 0, -bedL);
        box(10,15,10);
      popMatrix();
      translate(-bedW/2, -15, bedL/2);
      fill(50);
      box(bedW+30, 10, bedL+30);
      
      translate(0, -20, 0);
      fill(100);
      box(bedW+20, 30, bedL+25);
      
      translate(bedW/2+12, -18, 0);
      fill(150);
      box(5, 65, bedL+30);
      
      pushMatrix();
        translate(-20, closelyH - 4, 0);    // closely
        fill(200);
        box(30, 12, bedL/2);
        closelyX = modelX(0, 0, 0);
        closelyY = modelY(0, 0, 0);
        closelyZ = modelZ(0, 0, 0);
      
        if(closelyActive){
          pushMatrix();
            translate(-16, 3, -22);
            rotateY(radians(270));
            fill(0);
            text("press E", 0, 0, 0);
          popMatrix();
        }
      popMatrix();
      
      translate(-15, 3, 0);
      fill(100, 100, 0);
      box(10, 5, bedL/4);          // key
      
      noFill();
    popMatrix();
  }
  
  void collision(){
    if(eyeX <= bedX + 90 && eyeX > bedX - bedW - 90
      //&& eyeY > doorY && eyeY < doorY + doorH*2
      && eyeZ >= bedZ - 120 && eyeZ < bedZ + bedL + 100){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("bed oops");
    }else{
      col = false;
    }
    
    if((traceX < closelyX - 80)
    //&& (traceY > doorY + doorH*2 || traceY + traceH < doorY)
     ||(traceZ + traceL <= closelyZ - 50 || traceZ >= closelyZ)
    ){
      closelyActive = false;
      closelyAction = false;
      closelyH = 0;
    }else{
      closelyActive = true;
      println("closely trace");
    }
  }
  
  void Action(){       
    if(closelyAction){
      if(closelyH >= -20)
      closelyH -= 2;
    }else{
      closelyH = 0;
    }
  }
  
}

class desk{            // ------------------------------------------------------------ desk ----------------------------------------------------------------------
  float deskX, deskY, deskZ;
  
  desk(float x, float y, float z){
    deskX = x;
    deskY = y;
    deskZ = z;
    
  }
  
  void update(){
    pushMatrix();
      fill(200, 255, 240);
      translate(deskX, deskY, deskZ);
      pushMatrix();
        translate(0, -15, 0);
        box(200, 10, 380);
      popMatrix();
    
      pushMatrix();
      translate(0, 30, -85);
      box(200, 80, 20);
      popMatrix();
      
      pushMatrix();
      translate(0, 30, 180);
      box(200, 80, 20);
      popMatrix();
      
      //upper drawer
      //change upperX to close(+) or open(-)
      pushMatrix();
      float upperX = 0;
      translate(upperX, 5, 135);
      fill(255, 255, 200);
        pushMatrix();
        translate(0, 0, -30);
        box(200, 30, 10);
        popMatrix();
        pushMatrix();
        translate(0, 0, 30);
        box(200, 30, 10);
        popMatrix();
        pushMatrix();
        translate(0, 15, 0);
        box(200, 10, 70);
        popMatrix();
      popMatrix();
            
      //lower drawer
      //change lowerX to close(+) or open(-)
      pushMatrix();
      float lowerX = 0;
      translate(lowerX, 45, 135);
      fill(255, 200, 255);
       pushMatrix();
        translate(0, 0, -30);
        box(200, 40, 10);
        popMatrix();
        pushMatrix();
        translate(0, 0, 30);
        box(200, 40, 10);
        popMatrix();
        pushMatrix();
        translate(0, 17.5, 0);
        box(200, 10, 70);
        popMatrix();
      //box(200, 45, 70);
      popMatrix();
      
      noFill();
      popMatrix();
  }
  
}

class closet{          // ------------------------------------------------------------ closet ----------------------------------------------------------------------
 float closetX, closetY, closetZ;
 
 closet(float x, float y, float z) {
   closetX = x;
   closetY = y;
   closetZ = z;
 }
 
 void update(){
   pushMatrix();
     translate(closetX, closetY, closetZ);
     
   popMatrix();
     
 }
 
}

void bottom(){            // ---------------------------------------------------------------------- wall bottom --------------------------------------------------------------
  for(int i = -300; i <= 400; i += wallX){
    for(int j = -300; j <= 400; j += wallY){
      pushMatrix();
      translate(i,70,j);
      box(wallX,5,wallY);
      popMatrix();
    }
  }
}

void top(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = -300; j <= 400; j += wallY){
      pushMatrix();
      translate(i,-150,j);
      box(wallX,5,wallY);
      popMatrix();
    }
  }
}

void wall_z(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = 70; j > -170; j -= wallY){
      pushMatrix();
      translate(i,j,-330);
      box(wallX,wallY,5);
      popMatrix();
    }
  }
  
  if(eyeZ < -150 &&
    eyeX >= -300 && eyeX < 400
    //&& eyeY > doorY && eyeY < doorY + doorH*2
    && eyeZ < -200){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("oops");
    }else{
      col = false;
    }
    
}

void wallz(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = 70; j > -170; j -= wallY){
      pushMatrix();
      translate(i,j,430);
      box(wallX,wallY,5);
      popMatrix();
    }
  }
  
  if(eyeZ > 150 &&
    eyeX >= -300 && eyeX < 400
    //&& eyeY > doorY && eyeY < doorY + doorH*2
    && eyeZ > 300){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("oops");
    }else{
      col = false;
    }
}

void wall_x(){
  for(int j = 70; j > -170; j -= wallY){
    for(int i = -300; i <= -50; i += wallX){    // left
      pushMatrix();
      translate(-300,j,i);
      box(5,wallY,wallX);
      popMatrix();
    }
    for(int i = 100; i <= 400; i += wallX){    // right
      pushMatrix();
      translate(-300,j,i);
      box(5,wallY,wallX);
      popMatrix();
    }
  }
  
  for(int i = 0; i <= 50; i += wallX){        // middle
    for(int j = -120; j > -200; j -= wallY){
      pushMatrix();
      translate(-300,j,i);
      box(5,wallY,wallX);
      popMatrix();
    }
  }
  
  if(eyeX < -100 &&
    (eyeZ >= -300 && eyeZ < -30 && eyeX < -170) || (eyeZ >= 100 && eyeZ < 400 && eyeX < -170)
    //&& eyeY > doorY && eyeY < doorY + doorH*2
    ){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("oops");
    }else{
      col = false;
    }
}

void wallx(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = 70; j > -170; j -= wallY){
      pushMatrix();
      translate(400,j,i);
      box(5,wallY,wallX);
      popMatrix();
    }
  }
  
  if(eyeX > 100 &&
    //eyeZ >= -300 && eyeZ < 300 &&
    eyeX > 270
    //&& eyeY > doorY && eyeY < doorY + doorH*2
    ){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("oops");
    }else{
      col = false;
    }
}

void collision(){
  if(col == false){
    curX = eyeX;
    curY = eyeY;
    curZ = eyeZ;
  }
      
}

void boxCasting(){              //------------------------------------------------------ boxCasting ----------------------------------------------------------
  pushMatrix();
  //rotateY(10);
    translate(eyeX,eyeY,eyeZ);
    pushMatrix();
      rotateY(-radians(angle));
      rotateX(angleY);
      translate(0, 0, -50);
      //rotateY(-radians(angle));
      //rotateX(10);
      //fill(0);
      //noFill();
      box(traceW,traceH,traceL);
      //d1.Action();
      fill(200);
      traceX = modelX(0, 0, 0);
      traceY = modelY(0, 0, 0);
      traceZ = modelZ(0, 0, 0);
      println("traceX : "+traceX);
      println("traceY : "+traceY);
      println("traceZ : "+traceZ);
      //translate(traceW/2, -traceH, traceL);
      //box(traceW,traceH,traceL);
    popMatrix();
    //box(traceW,traceH,traceL);
  popMatrix();
}


void keyPressed(){          //------------------------------------------------------ keyPressed ----------------------------------------------------------
  //println(keyCode);
  switch(keyCode){
    case 87:    // up
      cameraFront = true;
      break;
    case 83:    // down
      cameraBack = true;
      break;
    case 65:    // left
      cameraLeft = true;
      break;
    case 68:    // right
      cameraRight = true;
      break;
    case 69:    // E: action
      if(doorActive){
        doorAction = true;
        doorActionTime = millis();
      }
      if(closelyActive){
        if(!closelyAction){
          closelyAction = true;
        }else{
          closelyAction = false;
        }
      }
      break;
  }
}

void keyReleased(){
  switch(keyCode){
    case 87:    // up
      cameraFront = false;
      break;
    case 83:    // down
      cameraBack = false;
      break;
    case 65:    // left
      cameraLeft = false;
      break;
    case 68:    // right
      cameraRight = false;
      break;
  }
}

void mouseClicked(){
  if(mouseButton == LEFT){
    if(handLight == 240){
      handLight = 0;
    }else{
      handLight = 240;
    }
  }
  if(mouseButton == RIGHT){
    if(eyeY < 0)
    eyeY += 10;
  }
}