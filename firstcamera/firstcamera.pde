PImage doorImg;
PImage wallImg;
PImage texImg;
PImage floorImg;
PImage pictureImg;

float eyeX, eyeY, eyeZ;
float seeX, seeY, seeZ;
float characterH = 0;

float x, y, z;
float sx, sy, sz;
float cameratime;
boolean cameraActive;
float eyeblow1x;
float eyeblow2x;
float eyeblowS1x;
float eyeblowS2x;
boolean eyeblowSwitch;

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
float moveSpeed = 800;

boolean cameraLeft, cameraRight, cameraFront, cameraBack;

float curX, curY, curZ;
boolean col;

boolean doorActive;
boolean doorAction;
boolean doorOpen;
int doorActionTime;

boolean closelyActive;
boolean closelyAction;

boolean deskUpperAction;
boolean deskUpperActive;
boolean deskLowerAction;
boolean deskLowerActive;

<<<<<<< HEAD
boolean roomLight = false;

=======
boolean closetActive;
boolean closetAction;

boolean closelyActive;
boolean closelyAction;
>>>>>>> origin/kimering

boolean keyActive;
boolean keyAction;
boolean haveKey = false;
int keyActionTime;
boolean keyMessage = false;


door d1 = new door(-300,-55,50,5,80,50,"-x",10,0);      //float x, float y, float z, float w, float h, float l, String direction, float tx, float tz)
bed b1 = new bed(360,60,290,260,10,100);
desk dk1 = new desk(360, 0, -230) ;
closet c = new closet(-180, -20, -285);

long startTime;
long endTime;
long ltime;

int page = 1;

// ---- menu
float ran;
int light;
boolean lights = false;
boolean blood = false;

void setup(){
  //fullScreen(P3D);
  size(1920,1080,P3D);

  doorImg = loadImage("door.png");
  wallImg = loadImage("wall.jpg");
  texImg = loadImage("tex2.jpg");
  floorImg = loadImage("floor.jpg");
  pictureImg = loadImage("wallpicture.jpg");
  //noLights();
  eyeX = 260;
  eyeY = -50;
  eyeZ = 106;
  
  seeX = -2;
  seeY = -60;
  seeZ = 0.0;
  
  x = 316;
  y = -30;
  z = 320;
  sx = 311;
  sy = -120;
  sz = 320;
  cameraActive = true;    //
  eyeblow1x = 150; 
  eyeblow2x = 450; 
  eyeblowS1x = 330;
  eyeblowS2x = 290;
  eyeblowSwitch = false;
  
  
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
  
  deskUpperAction = false;
  deskUpperActive = false;
  deskLowerAction = true;
  deskLowerActive = true;
  
  closetActive = true;
  closetAction = false;
  
  handLight = 0;
  
  traceW = 20;
  traceH = 20;
  traceL = 100;
  
  d1.doorSetup();
  
}

void draw(){
  if(page == 1){
    noCursor();
    background(0);
    noStroke();
    ambientLight(10, 10, 10);
    
    eyeY = -50+sin(radians(characterH))*8;
    //traceX = eyeX + traceW/3;
    //traceY = eyeY + traceH;
    //traceZ = eyeZ - traceL - 100;
   
   
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
    
    if(cameraFront || cameraRight || cameraLeft || cameraBack){
      characterH += 7;
    }else{
      characterH = 0;
    }
    
    if(roomLight){
      pointLight(20, 20, 20, 0, -100, 0);
    }else{
      pointLight(150, 150, 150, 0, -50, 0);
    }
    //pointLight(20, 20, 20, 0, -100, 0);
    //spotLight(0, 255, 0, 0, -150, 0, 0, 100, 0, 0.3, 1);
    if(cameraActive){
      cameraUpdate();
      camera(eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.0, 1.0, 0.0);
      //lightFalloff(0, 0.005, 0);
      spotLight(handLight, handLight, handLight, eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.4, 10);
    }else{
      intro();
    }
    //spotLight(handLight, handLight, handLight, eyeX, eyeY, eyeZ, seeX, seeY, seeZ, 0.4, 5);
    
    println("eyeX : "+eyeX);
    println("eyeY : "+eyeY);
    println("eyeZ : "+eyeZ);
    println("seeX : "+seeX);
    println("seeY : "+seeY);
    println("seeZ : "+seeZ);
    println("----------------------");
    
    lightBurn();
    
    //pushMatrix();
    d1.update();
    //popMatrix();
    d1.collision();
    //d1.Action();
    
    b1.update();
    b1.collision();
    b1.Action();
    
    dk1.update();
    dk1.collision();
    c.update();
    c.collision();
  
    
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
    picture();
    endTime = millis();
    ltime = endTime - startTime;
    println("wall TIME : " + ltime + "(ms)");
    
    collision();
      
  }else if(page == 0){
    menu();
  }
}


void cameraUpdate(){              //------------------------------------------------------ cameraUpdate ----------------------------------------------------------
  
  Xcomp = seeX - eyeX;
  Zcomp = seeZ - eyeZ;
  Ycomp = seeY - eyeY;
  
  angle = correctAngle(Xcomp, Zcomp);
  
  float cameraRotateX = (pmouseX - mouseX)*1.5;
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
        beginShape(QUADS);      // door texture
        texture(doorImg);
        vertex(3,-doorH/2,0,0,0);
        vertex(3,-doorH/2,-doorL,125,0);
        vertex(3,doorH/2,-doorL,125,250);
        vertex(3,doorH/2,0,0,250);
        endShape();
        beginShape(QUADS);      // door texture
        texture(doorImg);
        vertex(3,doorH/2,0,0,250);
        vertex(3,doorH/2,-doorL,125,250);
        vertex(3,doorH*1.5,-doorL,125,500);
        vertex(3,doorH*1.5,0,0,500);
        endShape();
        beginShape(QUADS);      // door texture
        texture(doorImg);
        vertex(3,-doorH/2,-doorL,125,0);
        vertex(3,-doorH/2,-doorL*2,250,0);
        vertex(3,doorH/2,-doorL*2,250,250);
        vertex(3,doorH/2,-doorL,125,250);
        endShape();
        beginShape(QUADS);      // door texture
        texture(doorImg);
        vertex(3,doorH/2,-doorL,125,250);
        vertex(3,doorH/2,-doorL*2,250,250);
        vertex(3,doorH*1.5,-doorL*2,250,500);
        vertex(3,doorH*1.5,-doorL,125,500);
        endShape();
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
        rotateX(-angleY);
        translate(0, 0, 50);
        fill(0);
        text("No Key.", -25, 60, -110);
        noFill();
 
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
  float keyX, keyY, keyZ;
  float keyColor = 100;
  
  bed(float x, float y, float z, float w, float h, float l){
    bedX = x;
    bedY = y;
    bedZ = z;
    bedW = w;
    bedH = h;
    bedL = l;
  }
  
  void update(){
    //println(closelyX +"  "+ closelyY +"  "+ closelyZ);
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
      
      if(!haveKey){
        pushMatrix();
          translate(-15, 3, 0);
          fill(keyColor, keyColor, 0);
          //emissive(50, 50, 0);
          box(10, 5, bedL/4);          // key
          //emissive(0, 0, 0);
          keyX = modelX(0, 0, 0);
          keyY = modelY(0, 0, 0);
          keyZ = modelZ(0, 0, 0);
        popMatrix();
      }
      
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
     ||(traceZ + traceL <= closelyZ - 60 || traceZ >= closelyZ)
    ){
      closelyActive = false;
      closelyAction = false;
      closelyH = 0;
    }else{
      closelyActive = true;
      println("closely trace");
    }
    
    if((traceX < keyX - 70)
    //&& (traceY > doorY + doorH*2 || traceY + traceH < doorY)
     ||(traceZ + traceL <= keyZ - 50 || traceZ >= keyZ)
    ){
      keyColor = 100;
      keyActive = false;
      //closelyAction = false;
      //closelyH = 0;
    }else{
      if(closelyAction){
        keyActive = true;
        keyColor = 200;
        println("key trace");
      }
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
  
  void message(){
    if(haveKey && !keyMessage){
        if(millis() - keyActionTime >= 1500){
          keyMessage = true;
        }
        rotateX(-angleY);
        translate(0, 0, 50);
        fill(0);
        text("get a Key.", -25, 60, -110);
        println("123");
        noFill();
    }
  }
  
}

class desk{            // ------------------------------------------------------------ desk ----------------------------------------------------------------------
  float deskX, deskY, deskZ;
  float upperX, lowerX;
  desk(float x, float y, float z){
    deskX = x;
    deskY = y;
    deskZ = z;
    
    upperX = 0;
    lowerX = 0;    
  }
  
  void update(){
    pushMatrix();
      fill(200, 255, 240);
      translate(deskX, deskY, deskZ);
      pushMatrix();
        translate(0, -15, 10);
        box(150, 10, 270);
      popMatrix();
    
      pushMatrix();
        pushMatrix();
        translate(0, 30, -85);
        box(150, 80, 12);
        popMatrix();
        translate(0, 0, -40);  
          pushMatrix();
          translate(0, 30, 175);
          box(150, 80, 12);
          popMatrix();
          
          //upper drawer
          //change upperX to close(+) or open(-)
          pushMatrix();
          float upperX = 0;
          translate(upperX, 5, 135);
          fill(255, 255, 200);
            pushMatrix();
            translate(0, 2.5, -30);
            box(150, 30, 10);
            popMatrix();
            pushMatrix();
            translate(0, 2.5, 30);
            box(150, 30, 10);
            popMatrix();
            pushMatrix();
            translate(0, 15, 0);
            box(150, 10, 70);
            popMatrix();
            pushMatrix();
            translate(-80, 2.5, 0);
            box(10, 35, 70);
            popMatrix();
          popMatrix();
                
          //lower drawer
          //change lowerX to close(+) or open(-)
          pushMatrix();
        
          //if( (lowerX<=0) && (lowerX>=-60)){
            println("lowerActive : " + deskLowerAction);
            
            if(!deskLowerAction){
              lowerX--;
              if( lowerX<-60 ) lowerX = -60;
              else if( lowerX>0 ) lowerX = 0;
            }
            else if(deskLowerAction){
             lowerX++; 
             if( lowerX<-60 ) lowerX = -60;
             else if( lowerX>0 ) lowerX = 0;
            }
         // }
      
          translate(lowerX, 45, 135);
          fill(255, 200, 255);
          pushMatrix();
            translate(0, 2.5, -30);
            box(150, 35, 10);
            popMatrix();
            pushMatrix();
            translate(0, 2.5, 30);
            box(150, 35, 10);
            popMatrix();
            pushMatrix();
            translate(0, 17.5, 0);
            box(150, 10, 70);
            popMatrix();
            pushMatrix();
            translate(-80, 2.5, 0);
            box(10, 40, 70);
            popMatrix();
          //box(200, 45, 70);
          popMatrix();
        popMatrix();
      noFill();
      popMatrix();
  }
  
  void collision(){
    if(eyeX <= deskX + 100 && eyeX > deskX - 190
      //&& eyeY > doorY && eyeY < doorY + doorH*2
      && eyeZ >= deskZ - 120 && eyeZ < deskZ + 240){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("desk oops");
    }else{
      col = false;
    }
  }
  
}

class closet{          // ------------------------------------------------------------ closet ----------------------------------------------------------------------
 float closetX, closetY, closetZ;
 float closetRate;
 
 closet(float x, float y, float z) {
   closetX = x;
   closetY = y;
   closetZ = z;
   closetRate = PI;
 }
 
 void update(){
   pushMatrix();
     translate(closetX, closetY, closetZ);
     fill(200, 200, 0);
     //box(120, 160, 80);
     pushMatrix();
     translate(0, 70, 0);
     box(120, 10, 80);
     popMatrix();
     
     pushMatrix();
     translate(0, -90, 0);
     box(120, 10, 80);
     popMatrix();
     
     pushMatrix();
     translate(-55, -10, 0);
     box(10, 160, 80);
     popMatrix();
     
     pushMatrix();
     translate(55, -10, 0);
     box(10, 160, 80);
     popMatrix();
  
     pushMatrix();
     translate(0, -10, -35);
     box(120, 160, 10);
     popMatrix();
     
     
     //draw door(?)
     if(closetAction){
        closetRate += PI/36;
        if( closetRate<PI ) closetRate = PI;
        else if( closetRate>PI+PI/9*7 ) closetRate = PI+PI/9*7;
      }
      else if(!closetAction){
       closetRate -= PI/36; 
       if( closetRate<PI ) closetRate = PI;
       else if( closetRate>PI+PI/9*7 ) closetRate = +PI/9*7;
      }

     fill(170, 180, 255);
     pushMatrix();
     translate(0, 0, 40);
       pushMatrix();
         translate(60, 0, 0);
         rotateY(closetRate);
         pushMatrix();
         translate(30, -10, 0);
         box(60, 170, 10);
         popMatrix();
       popMatrix();
       
       pushMatrix();
         translate(-60, 0, 0);
         rotateY(-closetRate);
         pushMatrix();
         translate(-30, -10, 0);
         box(60, 170, 10);
         popMatrix();
       popMatrix();
     popMatrix();
     
     //draw legs
     fill(60);
     pushMatrix();
     translate(50, 85, 0);
     box(20, 20, 80);
     popMatrix();
       
     pushMatrix();
     translate(-50, 85, 0);
     box(20, 20, 80);
     popMatrix();  
  
    
  
   noFill();
   popMatrix();
     
 }
 
 void collision(){
    if(eyeX <= closetX + 150 && eyeX > closetX - 100
      //&& eyeY > doorY && eyeY < doorY + doorH*2
      && eyeZ >= closetZ - 120 && eyeZ < closetZ + 160){
      col = true;
      eyeX = curX;
      eyeZ = curZ;
      println("closet oops");
    }else{
      col = false;
    }
  }
  
}

void bottom(){            // ---------------------------------------------------------------------- wall bottom --------------------------------------------------------------
  for(int i = -300; i <= 400; i += wallX){
    for(int j = -300; j <= 400; j += wallY){
      pushMatrix();
      translate(i,70,j+25);
          beginShape(QUADS);      // wall texture
          texture(floorImg);
          vertex(0,-3,0,0,0);
          vertex(wallX,-3,0,400,0);
          vertex(wallX,-3,-wallY,400,400);
          vertex(0,-3,-wallY,0,400);
          endShape();
      popMatrix();
    }
  }
}

void top(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = -300; j <= 400; j += wallY){
      pushMatrix();
      translate(i,-150,j+25);
          beginShape(QUADS);      // wall texture
          texture(texImg);
          vertex(0,3,0,0,0);
          vertex(wallX,3,0,512,0);
          vertex(wallX,3,-wallY,512,512);
          vertex(0,3,-wallY,0,512);
          endShape();
      popMatrix();
    }
  }
  
  pushMatrix();
    translate(0,-145,25);
    fill(250,250,250);
    if(!roomLight){
      emissive(160,160,50);
    }
    box(30,3,30);
    emissive(0,0,0);
  popMatrix();
}

void wall_z(){
  for(int i = -300; i <= 400; i += wallX){
    for(int j = 70; j > -170; j -= wallY){
      pushMatrix();
      translate(i,j,-330);
        beginShape(QUADS);      // wall texture
        texture(wallImg);
        vertex(0,0,3,0,0);
        vertex(wallX,0,3,1600,0);
        vertex(wallX,-wallY,3,1600,1014);
        vertex(0,-wallY,3,0,1014);
        endShape();
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
        beginShape(QUADS);      // wall texture
        texture(wallImg);
        vertex(0,0,-3,0,0);
        vertex(wallX,0,-3,1600,0);
        vertex(wallX,-wallY,-3,1600,1014);
        vertex(0,-wallY,-3,0,1014);
        endShape();
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
        pushMatrix();
          translate(0,0,-25);
          beginShape(QUADS);      // wall texture
          texture(wallImg);
          vertex(3,0,0,0,0);
          vertex(3,0,wallX,1600,0);
          vertex(3,-wallY,wallX,1600,1014);
          vertex(3,-wallY,0,0,1014);
          endShape();
        popMatrix();
      box(5,wallY,wallX);
      popMatrix();
    }
    for(int i = 100; i <= 400; i += wallX){    // right
      pushMatrix();
      translate(-300,j,i);
        pushMatrix();
          translate(0,0,-25);
          beginShape(QUADS);      // wall texture
          texture(wallImg);
          vertex(3,0,0,0,0);
          vertex(3,0,wallX,1600,0);
          vertex(3,-wallY,wallX,1600,1014);
          vertex(3,-wallY,0,0,1014);
          endShape();
        popMatrix();
      box(5,wallY,wallX);
      popMatrix();
    }
  }
  
  for(int i = 0; i <= 50; i += wallX){        // middle
    for(int j = -120; j > -200; j -= wallY){
      pushMatrix();
      translate(-300,j,i);
        pushMatrix();
          translate(0,25,-25);
          beginShape(QUADS);      // wall texture
          texture(wallImg);
          vertex(3,0,0,0,0);
          vertex(3,0,wallX,1600,0);
          vertex(3,-wallY,wallX,1600,1014);
          vertex(3,-wallY,0,0,1014);
          endShape();
        popMatrix();
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
      translate(400,j,i-25);
          beginShape(QUADS);      // wall texture
          texture(wallImg);
          vertex(-3,0,0,0,0);
          vertex(-3,0,wallX,1600,0);
          vertex(-3,-wallY,wallX,1600,1014);
          vertex(-3,-wallY,0,0,1014);
          endShape();
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

void picture(){
  pushMatrix();
    translate(-30,-115,425);
    translate(0,0,0);
      beginShape(QUADS);      // wall texture
      texture(pictureImg);
      vertex(0,0,0,0,0);
      vertex(-50,0,0,280,0);
      vertex(-50,70,0,280,373);
      vertex(0,70,0,0,373);
      endShape();
    translate(-50,0,0);
      beginShape(QUADS);      // wall texture
      texture(pictureImg);
      vertex(0,0,0,280,0);
      vertex(-50,0,0,560,0);
      vertex(-50,70,0,560,373);
      vertex(0,70,0,280,373);
      endShape();
    translate(0,70,0);
      beginShape(QUADS);      // wall texture
      texture(pictureImg);
      vertex(0,0,0,280,373);
      vertex(-50,0,0,560,373);
      vertex(-50,70,0,560,746);
      vertex(0,70,0,280,746);
      endShape();
    translate(50,0,0);
      beginShape(QUADS);      // wall texture
      texture(pictureImg);
      vertex(0,0,0,0,373);
      vertex(-50,0,0,280,373);
      vertex(-50,70,0,280,746);
      vertex(0,70,0,0,746);
      endShape();  
  popMatrix();
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
      noFill();
      box(traceW,traceH,traceL);
      d1.Action();
      b1.message();
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

void intro(){
  cameratime += 1;
  camera(x, y, z, sx, sy, sz, 0.0, 1.0, 0.0);
  if(cameratime < 400){
     pushMatrix();
        translate(eyeblowS1x, -130, 330);
        fill(0, 0, 0, 255);
        box(100, 1, 300);
        noFill();
      popMatrix();
      pushMatrix();
        translate(eyeblowS2x, -130, 330);
        fill(0, 0, 0, 255);
        box(100, 1, 300);
        noFill();
      popMatrix();
      eyeblowS1x += 0.5;
      eyeblowS2x -= 0.5;
    if(cameratime > 250){
      pushMatrix();
        translate(eyeblow1x, -130, 330);
        fill(0, 0, 0, 255);
        box(100, 1, 300);
        noFill();
      popMatrix();
      pushMatrix();
        translate(eyeblow2x, -130, 330);
        fill(0, 0, 0, 255);
        box(100, 1, 300);
        noFill();
      popMatrix();
      if(eyeblow1x < 150){
        eyeblowSwitch = false;
      }else if(eyeblow1x >= 250){
        eyeblowSwitch = true;
      }
      
      if(eyeblowSwitch){
        eyeblow1x -= 3;
        eyeblow2x += 3;
      }else{
        eyeblow1x += 3;
        eyeblow2x -= 3;
      }
    }  
    
  }else if(cameratime > 400 && cameratime < 800){
    if(sx > 170){
      x -= 0.2;
      y -= 0.05;
      sx -= 0.5;
      sy += 0.25;
     }
     //pushMatrix();
      //image(black, 300, -130);
     //popMatrix();
  }else if(cameratime > 800 && cameratime < 1000){
    if(sx < 250){
      z -= 0.1;
      sx += 0.5;
      sz -= 0.5;
    }
  }else if(cameratime > 1000 && cameratime < 1100){
    if(y > -50){
      y -= 0.1;
    }
     z -= 2;
     sz -= 2;
  }else if(cameratime > 1100 && cameratime < 1270){
    if(sx > 0){
      sx -= 3;
    }
    if(sz > 0){
      sz -= 3;
    }
  }else if(cameratime > 1230){
    cameraActive = true;
  }
  println("time : "+cameratime);
  println("x: "+x+"y: "+y+"z: "+z);
  println("sx: "+sx+"sy: "+sy+"sz: "+sz);
 
}

void menu(){
  background(0);
  noStroke();
  
  pushMatrix();
    noLights();
    rotateY(radians(270));
    rotateX(radians(10));
    translate(-200,0,200);
    fill(255);
    textSize(30);
    text("start", 0,0,0);
  popMatrix();
  
  pushMatrix();
    rotateY(radians(270));
    rotateX(radians(10));
    translate(-200,30,200);
    fill(255);
    textSize(20);
    text("", 0,0,0);
  popMatrix();
  
  pushMatrix();
    rotateY(radians(270));
    rotateX(radians(10));
    translate(-200,30,200);
    fill(255);
    textSize(20);
    text("exit", 0,0,0);
  popMatrix();
  
  if(lights){
    light = 200;
  }else{
    light = 0;
    blood = false;
  }
  
  ran = (float)random(20);
  if((ran >= 1 && ran <= 2)){
    if(ran > 1.8 && !lights){
      blood = true;
    }
    lights = true;
  }else if(ran >= 10 && ran <= 12){
    lights = false;
    //blood = false;
  }
  
  ambientLight(10, 10, 10); 
  spotLight(light, light, light, -100, -250, 0, 0, 100, 0, 0.5, 1);
  camera(-400, -100, 0, 0, 0, 0, 0.0, 1.0, 0.0);
  
  
  if(blood){
    pushMatrix();
      translate(-200,-10,-50);
      rotateX(radians(90));
      fill(200,0,0);
      ellipse(0,0,90,90);
      ellipse(60,-20,50,50);
      translate(10,50,0);
        ellipse(0,0,30,30);
        ellipse(-20,-10,20,20);
        translate(-50,-30,-1);
          ellipse(0,0,30,30);
          ellipse(0,-30,50,50);
          translate(80,0,0);
            ellipse(0,-60,30,30);
      //sphere(20);
      noFill();
    popMatrix();
  }
  
  pushMatrix();
    rotateY(90);
    for(int i = -300; i <= 400; i += 5){
      for(int j = -300; j <= 400; j += 5){
        pushMatrix();
        translate(i,0,j);
        fill(255);
        box(5,5,5);
        popMatrix();
      }
    }
  popMatrix();
  
  pushMatrix();
    translate(-100,-30,50);
    fill(200,200,200);
    sphere(30);
    noFill();
  popMatrix();
  
  
}

void keyPressed(){          //------------------------------------------------------ keyPressed ----------------------------------------------------------
  //println(keyCode);
<<<<<<< HEAD
  if(cameraActive){
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
=======
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
    case 69:    // E: actionFkeyF
      if(doorActive){
        doorAction = true;
        doorActionTime = millis();
      }
      
      if(closelyActive){
        if(!closelyAction){
          closelyAction = true;
        }else{
          closelyAction = false;
>>>>>>> origin/kimering
        }
        if(closelyActive){
          if(!closelyAction){
            closelyAction = true;
          }else{
            closelyAction = false;
          }
        }
        if(keyActive){
          haveKey = true;
          keyActionTime = millis();
        }
<<<<<<< HEAD
        break;
    }
=======
      }
      
      if(closetActive){
        if(closetAction) {
          closetAction = false;
        }
        else if(!closetAction) {
         closetAction = true; 
        }
      }
      
      break;
      
>>>>>>> origin/kimering
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
    if(handLight == 150){
      handLight = 0;
    }else{
      handLight = 150;
    }
  }
  if(mouseButton == RIGHT){
    if(eyeY < 0)
    eyeY += 10;
  }
}

void lightBurn(){
  if(!roomLight){
    if(eyeX > -50 && eyeX < 100 && eyeZ > -100 && eyeZ < 100){
      roomLight = true;
      
    }
  }
}