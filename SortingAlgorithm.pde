abstract class SortingAlgorithm{
    
    boolean sorted = false;
    int numComps = 0;
    int numSwaps = 0;
    
    abstract void step();
    
    void swap(int swap1, int swap2){
    
        // No additional memory required for swap
        
        if(swap1 == swap2){
            return;
        }
        
        arr[swap2] = arr[swap1] + arr[swap2];
        arr[swap1] = arr[swap2] - arr[swap1];
        arr[swap2] = arr[swap2] - arr[swap1];

        numSwaps++;

    }

    void reset(){
    
        sorted = false;
        numComps = numSwaps = 0;
    
    }

}
