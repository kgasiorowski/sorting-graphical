import java.util.Stack; //<>//

class QuickSort extends SortingAlgorithm{

    Stack<StackFrame> callStack;
    int low, high, pivot;
    
    QuickSort(){
    
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length-1));
        name = "Quick Sort";
    
        i = j = 0;
    
    }
    
    
    // This function should take a sub-array from index _low to _high and
    // pick some pivot and guarantee that:
    // Anything in that sub-array that's less than the pivot is below it, anything larger is above it
    // The function returns the new location of the pivot
    // In other words, the returned index is guaranteed to be correct
    int partition(int _low, int _high){
        
        int pivot = (_low + _high) / 2;
        swap(pivot, _low);
        
        int endOfLowArr = _low+1;
        
        for(i = _low+1; i <= _high; i++){
        
            if(arr[i] < arr[_low]){
            
                swap(endOfLowArr, i);
                endOfLowArr++;
            
            }
        
        }
        
        swap(_low, endOfLowArr);
        return endOfLowArr;
        
    }
    
    void step(){
    
        if(sorted)
            return;
        
        while(!callStack.empty()){
        
            StackFrame current = callStack.pop();
        
            low = current.low;
            high = current.high;
            
            int p = partition(low, high);
            
            if(p-1 > low){
            
                callStack.push(new StackFrame(low, p-1));
            
            }
            
            if(p+1 < high){
            
                callStack.push(new StackFrame(p+1, high));
            
            }
            
        
        }
        
        sorted = true;
    
    }

    void reset(){
    
        super.reset();
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length));
    
    }

}
