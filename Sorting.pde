String videoPath = "./img/";

int arr[];
float rect_pixel_width;
float startTime;
ArrayList<SortingAlgorithm> algos;
int currentAlgorithm;

float fontSize = 14;

final String shuffleText = "Shuffling";

String nameText = shuffleText;
String timeText = "";
String comparisonsText = "";
String swapsText = "";

void setup(){
    
    size(1280, 720);
    //fullScreen();
    
    rectMode(CORNER);
    background(0);

    algos = new ArrayList();

    //algos.add(new BubbleSort());
    //algos.add(new FastBubbleSort());
    //algos.add(new SelectionSort());
    //algos.add(new FastSelectionSort());
    //algos.add(new InsertionSort());
    //algos.add(new FastInsertionSort());
    algos.add(new QuickSort());
    
    //algos.add(new MergeSort());

    currentAlgorithm = 0;

    reset(false);

    frameRate(60);

}

boolean drawLines = false;
void keyPressed(){
    
    if(keyCode == 81){
    
        drawLines = !drawLines;
    
    }

}

// Call this function to re-initialize the currently running algorithm, with
// the option to randomize the array
void reset(boolean shuffle){
    
    println(algos.get(currentAlgorithm).arrSize);
    
    // Re-initialize the array
    arr = new int[algos.get(currentAlgorithm).arrSize];
        
    int i = 1;
    while((arr[i-1] = i++) < arr.length);
    
    // Shuffle the array
    if(shuffle){
    
        shuffleArray();
    
    }
    
    // Re-calculate the rectangle width
    rect_pixel_width = (float)width/(float)(algos.get(currentAlgorithm).arrSize);
    
    // Let the algorithm reset itself
    algos.get(currentAlgorithm).reset();
    
    // Record the new starting time
    startTime = millis();

}

boolean shuffling = true;
int shuffleCount;
boolean repeat = true;
boolean drawText = false;
void draw(){
    
    //Clear the background
    background(0);
    
    // Get a shorthand for the currently running algorithm
    SortingAlgorithm algo = algos.get(currentAlgorithm);
    
    // This code only runs after the algorithm has finished, and shuffling hasn't begun yet
    if(algo.sorted && !shuffling){
    
        delay(2000);
        
        // For now we just loop through all the algorithms once.
        // Once we do the entire array, just exit
        if(++currentAlgorithm >= algos.size()){
        
            if(repeat)
                currentAlgorithm = 0;
            else{
                //exit();
                noLoop();
                exit();
                return;
            }
            
        }
        
        // New algorithm, so we have to re-initialize it and tell the program to start shuffling
        reset(false);
        shuffling = true;
        shuffleCount = 0;
    
    }
    
    if(shuffling){
    
        // Swap one value out per frame until the each value is 
        // guaranteed to be swapped out at least once
        if(shuffleCount >= arr.length){
        
            shuffling = false;
            delay(2000);
            startTime = millis();
        
        }else{
        
            int swap = int(random(0, shuffleCount));
            
            if(swap != shuffleCount){
            
                arr[shuffleCount] = arr[swap] + arr[shuffleCount];
                arr[swap] = arr[shuffleCount] - arr[swap];
                arr[shuffleCount] = arr[shuffleCount] - arr[swap];
            
            }
            
            shuffleCount++;
        
        }
        
    }else{
    
        // If we're not shuffling, continue the algorithm
        algo.step();
    
    }
    
    // Draws the array of values + assorted lines for each algorithm
    for(int i = 0; i < arr.length; i++){
    
        color clr = mapColor(arr[i]);
        
        stroke(clr);
        fill(clr);
        rect(i * rect_pixel_width, map(arr[i], 0, arr.length, height, 0), rect_pixel_width, height);
        stroke(255);
    
        // If it's not done and we're not shuffling, draw some extra stuff
        if(!algo.sorted && !shuffling){
            
            if(algo instanceof QuickSort){
                
                QuickSort q = (QuickSort)algo;
                
                if(i == ((QuickSort)algo).pivotIndex)
                    horizLine(i);
            
                if(drawLines){
            
                    if(q.lastPopped != null)
                        if(i == q.lastPopped.low+1)
                            horizLine(i, color(0, 0, 255));
                        else if(i == q.lastPopped.high)
                            horizLine(i, color(255, 0, 0));
                
                    for(StackFrame s : q.callStack)
                        if(i == s.low+1)
                            horizLine(i, color(0, 0, 255));
                        else if(i == s.high)
                            horizLine(i, color(255, 0, 0));
            
                }
            
            }else if (algo instanceof BubbleSort){
    
                if(i == arr.length-algo.j+1)
                    horizLine(i);
            
            }else if(algo instanceof FastBubbleSort){
            
                if(i == arr.length-algo.j+1)
                    horizLine(i);
                
            }else if(algo instanceof SelectionSort){
            
                if(i == ((SelectionSort)algo).biggest+1 || i == algo.i)
                    horizLine(i);
            
            }else if(algo instanceof InsertionSort){
            
                if(i == algo.j)
                    horizLine(i);
            
            }
    
        }
    
    }

    if(!shuffling){
        
        // If we aren't shuffling, print stats
        nameText = algo.name + " (" + arr.length + " values)";
        timeText = getTimeString(millis());
        swapsText = "Swaps: " + algo.numSwaps;
        comparisonsText = "Comparisons: " + algo.numComps;
    
    }else{
    
        // If we are shuffling, print just the shuffle text
        nameText = shuffleText;
        timeText = "";
        comparisonsText = "";
        swapsText = "";
    
    }
    
    if(drawText){
    
        // Draw on-screen text as necessary
        fill(255);
        
        text(nameText, 10, 20);
        if(!shuffling && algo.sorted)
            fill(0,255,0);
            
        text(timeText, 10, 40);
        
        fill(255);
        
        text(swapsText, 10, 60);
        text(comparisonsText, 10, 80);

    }
    
    //saveFrame(videoPath + "gif--#####.png");
    
}

String getTimeString(int time){

    float timeSeconds = round((time - startTime)/100.0)/10.0;
    int timeMinutes = ((int)timeSeconds / 60);
    int timeHours = timeMinutes / 60;
    
    return String.format("%d:%d:%.1f", timeHours, timeMinutes%60, timeSeconds%60);

}

void horizLine(int i){

    line(i*rect_pixel_width - (0.5 * rect_pixel_width), 0, i*rect_pixel_width - (0.5 * rect_pixel_width), height);

}

void horizLine(int i, color clr){

    stroke(clr);
    horizLine(i);

}

void shuffleArray(){
    
    for(int i = 0; i < arr.length; i++){
    
        int swap = 0;
        
        swap = int(random(arr.length));
        
        if(swap == i)
            continue;
        
        arr[i] = arr[swap] + arr[i];
        arr[swap] = arr[i] - arr[swap];
        arr[i] = arr[i] - arr[swap];
        
    }

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
