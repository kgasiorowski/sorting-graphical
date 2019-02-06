class FastBubbleSort extends SortingAlgorithm{

    int j = 0;
    
    void step(){
    
        if(sorted)
            return;
        
        for(int i = 0; i < arr.length-1-j; i++){
        
            if(arr[i] > arr[i+1])
                swap(i, i+1);
            
            numComps++;
        
        }
        
        j++;
    
        if(j >= arr.length-1)
            sorted = true;
    
    }
    
    void reset(){
    
        super.reset();
        j = 0;
    
    }

}
