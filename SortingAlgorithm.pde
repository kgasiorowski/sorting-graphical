abstract class SortingAlgorithm{
    
    boolean sorted = false;
    int numComps = 0;
    int numSwaps = 0;
    
    abstract void step(int[] arr);
    
    void swap(int swap1, int swap2){
    
        int temp = arr[swap1];
        arr[swap1] = arr[swap2];
        arr[swap2] = temp;
    
        numSwaps++;
    
    }

    void reset(){
    
        sorted = false;
        numComps = numSwaps = 0;
    
    }

}
