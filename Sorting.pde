import controlP5.*;

int arr[];
int numVals = 150;
float rect_pixel_width;
float startTime;
SortingAlgorithm algo;

ControlP5 cp5;
Textlabel swapsLabel;
Textlabel compsLabel;
Textlabel timeLabel;

void setup(){

    size(700, 500);
    
    arr = new int[numVals];
    
    int i = 1;
    while((arr[i-1] = i++) < arr.length);

    println(width, height);
    rect_pixel_width = (float)width/(float)(arr.length);
    rectMode(CORNER);
    background(0);
    shuffle();

    algo = new SelectionSort();

    cp5 = new ControlP5(this);
    
    swapsLabel = cp5.addTextlabel("label")
        .setPosition(10, 10)
        .setColorValue(color(255))
        .setFont(createFont("",20));

    compsLabel = cp5.addTextlabel("label2")
        .setPosition(10, 30)
        .setColorValue(color(255))
        .setFont(createFont("",20));

    timeLabel = cp5.addTextlabel("label3")
        .setPosition(10, 50)
        .setColorValue(color(255))
        .setFont(createFont("",20));

    startTime = millis();

    frameRate(60);

}

void keyPressed(){

    if(keyCode == 32)
        reset();   
    

}

void reset(){

    noLoop();
    int i = 1;
    while((arr[i-1] = i++) < arr.length);
    algo.reset();
    startTime = millis();
    timeLabel.setColorValue(color(255));
    shuffle();
    redraw();
    loop();

}

void draw(){
    
    background(0);
    
    algo.step();
    
    for(int i = 0; i < arr.length; i++){
    
        color clr = mapColor(arr[i]);
        
        if(i == ((SelectionSort)(algo)).i || i == ((SelectionSort)(algo)).j)
            stroke(255);
        else if(i == ((SelectionSort)(algo)).biggest)
            stroke(255, 0, 255);
        else
            stroke(clr);
            
        fill(clr);
        rect(i * rect_pixel_width, getRectHeight(arr[i]), rect_pixel_width, height);
    
    }

    if(algo.sorted){
    
        timeLabel.setColorValue(color(0,255,0));
        noLoop();
    
    }
    
    float timeSeconds = round((millis() - startTime)/100.0)/10.0;
    int timeMinutes = ((int)timeSeconds / 60);
    int timeHours = timeMinutes / 60;
    
    String timeString = String.format("%d:%d:%.1f", timeHours, timeMinutes%60, timeSeconds%60);
    
    swapsLabel.setText("Swaps: " + algo.numSwaps);
    compsLabel.setText("Comps: " + algo.numComps);
    timeLabel.setText("Time elapsed: " + timeString);
    
}

void shuffle(){

    for(int i = 0; i < arr.length; i++){
    
        int swap1, swap2;
        swap1 = swap2 = 0;
        
        do{
            
            swap1 = int(random(arr.length));
            swap2 = int(random(arr.length));
        
        }while(swap1 == swap2);
        
        int temp = arr[swap1];
        arr[swap1] = arr[swap2];
        arr[swap2] = temp;
        
    }

}

float getRectHeight(int val){

    return map(val, 0, arr.length, height, height*.05);

}

color mapColor(int val){

    int red = 0;
    int green = 0;
    int blue = 0;
    
    int mappedVal = int(map(val, 0, arr.length, 0, 100));
    
    if(mappedVal <= 25){
    
        // Lowest level, blue -> cyan
        red = 0;
        green = int(map(mappedVal, 0, 25, 0, 255));
        blue = 255;
    
    }else if(mappedVal > 25 && mappedVal <= 50){
    
        // 2nd level, teal -> green
        red = 0;
        green = 255;
        blue = int(map(mappedVal, 25, 50, 255, 0));

    }else if(mappedVal > 50 && mappedVal <= 75){
        
        // 3rd level, green -> yellow
        red = int(map(mappedVal, 50, 75, 0, 255));
        green = 255;
        blue = 0;
    
    }else{
    
        // Top level, yellow -> red
        red = 255;
        green = int(map(mappedVal, 75, 100, 255, 0));
        blue = 0;
    
    }

    return color(red, green, blue);

}
