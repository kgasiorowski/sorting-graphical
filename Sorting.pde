import controlP5.*;

int arr[];
int numVals = 20;
float rect_pixel_width;
float startTime;
float pauseTime;
SortingAlgorithm[] algos;
int currentAlgorithm = 6;

float fontSize = 14;

ControlP5 cp5;
Textlabel swapsLabel;
Textlabel compsLabel;
Textlabel timeLabel;
Textlabel nameLabel;

void setup(){
    
    size(900, 700);
    
    arr = new int[numVals];
    
    int i = 1;
    while((arr[i-1] = i++) < arr.length);

    println(width, height);
    rect_pixel_width = (float)width/(float)(arr.length);
    rectMode(CORNER);
    background(0);
    shuffle();

    frameRate(60);

    algos = new SortingAlgorithm[7];

    algos[0] = new BubbleSort();
    algos[1] = new FastBubbleSort();
    algos[2] = new SelectionSort();
    algos[3] = new FastSelectionSort();
    algos[4] = new InsertionSort();
    algos[5] = new FastInsertionSort();
    algos[6] = new QuickSort();

    cp5 = new ControlP5(this);
    
    nameLabel = cp5.addTextlabel("meh lol")
        .setPosition(10, 10)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize))
        .setText(algos[currentAlgorithm].name);
        
    swapsLabel = cp5.addTextlabel("label")
        .setPosition(10, 30)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    compsLabel = cp5.addTextlabel("label2")
        .setPosition(10, 50)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    timeLabel = cp5.addTextlabel("label3")
        .setPosition(10, 70)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    startTime = millis();
    pauseTime = 0;

}

boolean looping = true;
void mousePressed(){

    if(algos[currentAlgorithm].sorted)
        return;
    
    if(looping){
    
        pauseTime -= millis();
        noLoop();
    
    }else{
    
        pauseTime += millis();
        loop();
        
    }
        
    looping = !looping;

}

void keyPressed(){
    
    if(keyCode == 32)
        reset();   
    else if(keyCode == 38){
    
        currentAlgorithm = (currentAlgorithm + 1) % algos.length;
        reset();
    
    }else if(keyCode == 40){
    
        currentAlgorithm = currentAlgorithm - 1 < 0 ? algos.length-1 : currentAlgorithm - 1;
        reset();
    
    }

}

void reset(){

    // Stop the program from looping
    noLoop();
    // Re-fill the array
    int i = 1;
    while((arr[i-1] = i++) < arr.length);
    // Let the algorithm reset
    algos[currentAlgorithm].reset();
    // Record the new starting time
    startTime = millis();
    // Reset the time label's color
    timeLabel.setColorValue(color(255));
    nameLabel.setText(algos[currentAlgorithm].name);
    // Shuffle the array
    shuffle();
    
    // Now re-start everything
    redraw();
    loop();

}

void draw(){
    
    background(0);
    
    SortingAlgorithm algo = algos[currentAlgorithm];
    
    algo.step();
    
    for(int i = 0; i < arr.length; i++){
    
        color clr = mapColor(arr[i]);
        
        stroke(clr);
        
        if(algo instanceof BubbleSort){
        
            if(i == algo.i || i == arr.length - algo.j - 1){
            
                stroke(255);
            
            }else{
            
                stroke(clr);
            
            }
        
        }else if(algo instanceof SelectionSort){
        
            if(i == algo.i || i == algo.j+1 || i == ((SelectionSort)(algo)).biggest){
            
                stroke(255);
            
            }else{
            
                stroke(clr);
            
            }
        
        }else if(algo instanceof QuickSort){
        
            QuickSort q = (QuickSort)algo;
            
            if(i == q.low || i == q.high){
            
                stroke(255);
                
            }else if(i == q.pivot){
            
                stroke(255, 0, 255);
            
            }
            
        
        }
            
        fill(clr);
        rect(i * rect_pixel_width, getRectHeight(arr[i]), rect_pixel_width, height);
    
    }

    if(algo.sorted){
    
        timeLabel.setColorValue(color(0,255,0));
        noLoop();
    
    }
    
    float timeSeconds = round((millis() - startTime - pauseTime)/100.0)/10.0;
    int timeMinutes = ((int)timeSeconds / 60);
    int timeHours = timeMinutes / 60;
    
    String timeString = String.format("%d:%d:%.1f", timeHours, timeMinutes%60, timeSeconds%60);
    
    swapsLabel.setText("Swaps: " + algo.numSwaps);
    compsLabel.setText("Comps: " + algo.numComps);
    timeLabel.setText("Time elapsed: " + timeString);
    
}

void shuffle(){

    for(int i = 0; i < arr.length; i++){
    
        int swap = 0;
        
        swap = int(random(arr.length));
        
        int temp = arr[i];
        arr[i] = arr[swap];
        arr[swap] = temp;
        
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
