import controlP5.*;

int arr[];
float rect_pixel_width;
float startTime;
float pauseTime;
SortingAlgorithm[] algos;
int currentAlgorithm;

float fontSize = 14;

ControlP5 cp5;
Textlabel swapsLabel;
Textlabel compsLabel;
Textlabel timeLabel;
Textlabel nameLabel;

void setup(){
    
    size(1200, 800);
    
    println(width, height);
    rectMode(CORNER);
    background(0);

    algos = new SortingAlgorithm[7];

    algos[0] = new BubbleSort();
    algos[1] = new FastBubbleSort();
    algos[2] = new SelectionSort();
    algos[3] = new FastSelectionSort();
    algos[4] = new InsertionSort();
    algos[5] = new FastInsertionSort();
    algos[6] = new QuickSort();

    currentAlgorithm = 0;

    shuffle(algos[currentAlgorithm].arrSize);

    rect_pixel_width = (float)width/(float)(algos[currentAlgorithm].arrSize);

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
//void mousePressed(){
    
//    if(algos[currentAlgorithm].sorted)
//        return;
    
//    if(looping){
    
//        pauseTime -= millis();
//        noLoop();
    
//    }else{
    
//        pauseTime += millis();
//        loop();
        
//    }
        
//    looping = !looping;

//}

void keyPressed(){
    
    if(keyCode == 32){
    
        reset();
        
    }else if(keyCode == 38){
    
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
    
    // Shuffle the array
    shuffle(algos[currentAlgorithm].arrSize);
    rect_pixel_width = (float)width/(float)(algos[currentAlgorithm].arrSize);
    
    // Let the algorithm reset
    algos[currentAlgorithm].reset();
    // Record the new starting time
    startTime = millis();
    pauseTime = 0;
    // Reset the time label's color
    timeLabel.setColorValue(color(255));
    timeLabel.setText(getTimeString(0));
    nameLabel.setText(algos[currentAlgorithm].name);
    
    
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
        
        } 
            
        fill(clr);
        rect(i * rect_pixel_width, getRectHeight(arr[i]), rect_pixel_width, height);
    
        if(algo instanceof QuickSort){
            
            if(i == ((QuickSort)algo).pivot){
            
                stroke(255);
                line(i*rect_pixel_width - (0.5 * rect_pixel_width), 0, i*rect_pixel_width - (0.5 * rect_pixel_width), height);
            
            }
        
        }
    
    }

    String timeString = getTimeString(millis());
    
    if(algo.sorted)
        timeLabel.setColorValue(color(0,255,0));
    
    swapsLabel.setText("Swaps: " + algo.numSwaps);
    compsLabel.setText("Comps: " + algo.numComps);
    timeLabel.setText("Time elapsed: " + timeString);

    if(algo.sorted){
    
        //noLoop();
        delay(3000);
    
        reset();
    
    }
    
    
    
}

String getTimeString(int time){

    float timeSeconds = round((time - startTime - pauseTime)/100.0)/10.0;
    int timeMinutes = ((int)timeSeconds / 60);
    int timeHours = timeMinutes / 60;
    
    return String.format("%d:%d:%.1f", timeHours, timeMinutes%60, timeSeconds%60);

}

void shuffle(int numVals){

    arr = new int[numVals];
    
    int i = 1;
    while((arr[i-1] = i++) < arr.length);
    
    for(i = 0; i < arr.length; i++){
    
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
    
    int maxMap = 100000;
    
    int mappedVal = int(map(val, 0, arr.length, 0, maxMap));
    
    if(mappedVal <= maxMap*.25){
    
        // Lowest level, blue -> cyan
        red = 0;
        green = int(map(mappedVal, 0, maxMap*.25, 0, 255));
        blue = 255;
    
    }else if(mappedVal > maxMap*.25 && mappedVal <= maxMap*.50){
    
        // 2nd level, teal -> green
        red = 0;
        green = 255;
        blue = int(map(mappedVal, maxMap*.25, maxMap*.50, 255, 0));

    }else if(mappedVal > maxMap*.50 && mappedVal <= maxMap*.75){
        
        // 3rd level, green -> yellow
        red = int(map(mappedVal, maxMap*.50, maxMap*.75, 0, 255));
        green = 255;
        blue = 0;
    
    }else{
    
        // Top level, yellow -> red
        red = 255;
        green = int(map(mappedVal, maxMap*.75, maxMap, 255, 0));
        blue = 0;
    
    }

    return color(red, green, blue);

}
