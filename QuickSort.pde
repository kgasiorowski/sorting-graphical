import java.util.Stack; //<>//

class QuickSort extends SortingAlgorithm{

    Stack<StackFrame> callStack;

    int low, high;
    int pivot;
    int pivotIndex;
    
    QuickSort(){
    
        arrSize = 300;
        callStack = new Stack();
        callStack.push(new StackFrame(0, arrSize-1));
        shuffle(arrSize);
        initCall(callStack.peek());
        name = "Quick Sort";
        
    }
    
    void initCall(StackFrame current){
        
        low = current.low;
        high = current.high;
        
        // pick the pivot
        //int middle = low + (high - low) / 2;
        int middle = (low + high) / 2;
        pivotIndex = middle;
        pivot = arr[middle];
 
        // make left < pivot and right > pivot
        i = low; 
        j = high;
    
        if(callStack.empty())
            pivot = -1;
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        if(!callStack.empty()){
        
            if(i <= j) {
                
                while (arr[i] < pivot){
                    i++;
                    numComps++;
                }
                
                numComps++;
                
                while (arr[j] > pivot){
                    j--;
                    numComps++;
                }
     
                numComps++;
     
                if (i <= j) {
                    swap(i,j);
                    i++;
                    j--;
                }
            
            }else{
             
                // Push the recursive calls to the stack
                if (high > i)
                    callStack.push(new StackFrame(i, high));
                
                if (low < j)
                    callStack.push(new StackFrame(low, j));
                
                // Initialize the new stack frame we have after the last one ended
                initCall(callStack.pop());
                
            }
        
        }else{
        
            sorted = true;
            //pivot = -1;
    
        }
    
    }

    void reset(){
    
        super.reset();
        arrSize = 300;
        callStack = new Stack();
        callStack.push(new StackFrame(0, arrSize-1));
        shuffle(arrSize);
        initCall(callStack.peek());
    
    }

}
