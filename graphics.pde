importprocessing.serial.*;//importslibraryforserialcommunication
importjava.awt.event.KeyEvent;//importslibraryforreadingthedatafromtheserialport
importjava.io.IOException;


SerialmyPort;//definesObjectSerial
//defubesvariablesStringangle="";Stringdistance="";Stringdata="";StringnoObject;floatpixsDistance;
intiAngle,iDistance;intindex1=0;
intindex2=0;PFontorcFont;

voidsetup(){


size(1920,1080);
smooth();printArray(Serial.list());
myPort=newSerial(this,Serial.list()[0],9600);
//myPort=newSerial(this,"COM6",9600);//startstheserialcommunication
myPort.bufferUntil('.');//readsthedatafromtheserialportuptothecharacter'.'.Soactuallyitreadsthis:angle,distance.
orcFont=loadFont("TheSans-Plain-12.vlw");
}
voiddraw(){


fill(98,245,31);
textFont(orcFont);
//simulatingmotionblurandslowfadeofthemovinglinenoStroke();
fill(0,4);
rect(0,0,width,1010);


fill(98,245,31);//greencolor
//callsthefunctionsfordrawingtheradardrawRadar();
drawLine();drawObject();drawText();
}


voidserialEvent(SerialmyPort){//startsreadingdatafromtheSerialPort
//readsthedatafromtheSerialPortuptothecharacter'.'andputsitintotheStringvariable"data".
data=myPort.readStringUntil('.');
data=data.substring(0,data.length()-1);
//myPort.write(data);
index1=data.indexOf(",");//findthecharacter','andputsitintothevariable"index1"
angle=data.substring(0,index1);//readthedatafromposition"0"topositionofthevariableindex1orthatsthevalueoftheangletheArduinoBoardsentintotheSerialPort
distance=data.substring(index1+1,data.length());//readthedatafromposition"index1"totheendofthedataprthatsthevalueofthedistance
//convertstheStringvariablesintoIntegeriAngle=int(angle);
iDistance=int(distance);
}


voiddrawRadar(){pushMatrix();
translate(640,680);//movesthestartingcoordinatstonewlocationnoFill();
strokeWeight(2);stroke(98,245,31);
//drawsthearclinesarc(0,0,1200,1200,PI,TWO_PI);arc(0,0,900,900,PI,TWO_PI);arc(0,0,600,600,PI,TWO_PI);arc(0,0,300,300,PI,TWO_PI);
//drawstheanglelinesline(-640,0,640,0);
line(0,0,-640*cos(radians(30)),-640*sin(radians(30)));line(0,0,-640*cos(radians(60)),-640*sin(radians(60)));line(0,0,-640*cos(radians(90)),-640*sin(radians(90)));line(0,0,-640*cos(radians(120)),-640*sin(radians(120)));line(0,0,-640*cos(radians(150)),-640*sin(radians(150)));line(-640*cos(radians(30)),0,640,0);
popMatrix();
}


voiddrawObject(){pushMatrix();
translate(640,680);//movesthestartingcoordinatstonewlocation
strokeWeight(6);stroke(255,10,10);//red color
pixsDistance=iDistance*22.5;//coversthedistancefromthesensorfromcmtopixels
//limitingtherangeto40cmsif(iDistance<40){
//drawstheobjectaccordingtotheangleandthedistance
line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),630*cos(radians(iAngle)),-630*sin(radians(iAngle)));
}
popMatrix();
}


voiddrawLine(){pushMatrix();strokeWeight(6);stroke(30,250,60);
translate(640,680);//movesthestartingcoordinatstonewlocation
line(0,0,630*cos(radians(iAngle)),-630*sin(radians(iAngle)));//draws thelineaccordingtotheangle
popMatrix();
}


voiddrawText(){//drawsthetextsonthescreen


pushMatrix();if(iDistance>40){
noObject="OutofRange";
}
else{
noObject="InRange";
}
fill(0,0,0);noStroke();
rect(0,1010,width,1080);fill(98,245,31);
textSize(20);text("10cm",740,670);
text("20cm",890,670);
text("30cm",1040,670);
text("40cm",1190,670);
textSize(20);
text("Object:"+noObject,140,710);text("Angle:"+iAngle+"°",630,710);text("Distance:",830,710);if(iDistance<40){
text("	"+iDistance+"cm",900,710);
}
textSize(25);fill(98,245,60);
translate(641+640*cos(radians(30)),662-640*sin(radians(30)));rotate(-radians(-60));
text("30°",0,0);
resetMatrix();
translate(634+640*cos(radians(60)),664-640*sin(radians(60)));rotate(-radians(-30));
text("60°",0,0);
resetMatrix();
translate(625+640*cos(radians(90)),670-640*sin(radians(90)));rotate(radians(0));
text("90°",0,0);
resetMatrix();
translate(615+640*cos(radians(120)),683-640*sin(radians(120)));rotate(radians(-30));
text("120°",0,0);
resetMatrix();
translate(620+640*cos(radians(150)),698-640*sin(radians(150)));rotate(radians(-60));
text("150°",0,0);
popMatrix();
}

