class BubbleSort extends SortingAlgorithm{
    
    BubbleSort(){
    
        i = 0;
        j = 0;
        name = "Bubble Sort";
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        if(arr[i] > arr[i+1])
            swap(i, i+1);
    
        i++;
        
        numComps++;
        if(i >= arr.length-1-j)
        {
        
            i = 0;
            j++;
        
        }
    
        if(j >= arr.length-1)
            sorted = true;
    
    }
    
    void reset(){
    
        super.reset();
        i = j = 0;
    
    }

}
