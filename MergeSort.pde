import java.util.Stack;

enum MState {

    Starting,
    Sorting
    
}

class MergeSort extends SortingAlgorithm{
    
    private Stack<StackFrame> stack;
    private int l, r;
    
    public MergeSort(){
    
        arrSize = 100;
        stack = new Stack();
        name = "Merge Sort";
        l = 0;
        r = arrSize-1;
    
    }
    
    void step(){

        if(sorted)
            return;
        
        mergeSort(0, arrSize-1);
    
        sorted = true;
    
    }

    void mergeSort(int l, int r) 
    { 
        if (l != r) { 
      
            // Same as (l + r) / 2, but avoids overflow 
            // for large l and r 
            int m = l + (r - l) / 2; 
      
            // Sort first and second halves 
            mergeSort(l, m); 
            mergeSort(m + 1, r); 
      
            merge(l, m, r); 
        } 
    }

    void merge(int start, int mid, int end) 
    { 
        int start2 = mid + 1; 
      
        // If the direct merge is already sorted 
        if (arr[mid] <= arr[start2]) { 
            return; 
        } 
      
        // Two pointers to maintain start 
        // of both arrays to merge 
        while (start <= mid && start2 <= end) { 
      
            // If element 1 is in right place 
            if (arr[start] <= arr[start2]) { 
                start++; 
            } 
            else { 
                int value = arr[start2]; 
                int index = start2; 
      
                // Shift all the elements between element 1 
                // element 2, right by 1. 
                while (index != start) { 
                    arr[index] = arr[index - 1]; 
                    index--; 
                } 
                arr[start] = value; 
      
                // Update all the pointers 
                start++; 
                mid++; 
                start2++; 
            } 
        } 
    } 
    
    void reset(){
    
        super.reset();
        stack = new Stack();
        l = 0;
        r = arrSize-1;
    
    }
}
